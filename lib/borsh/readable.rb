# This is free and unencumbered software released into the public domain.

require 'set'

module Borsh::Readable
  def read_object(type)
    case type
      when :nil     then self.read_unit
      when :bool    then self.read_bool
      when :u8      then self.read_u8
      when :u16     then self.read_u16
      when :u32     then self.read_u32
      when :u64     then self.read_u64
      when :u128    then self.read_u128
      when :i8      then self.read_i8
      when :i16     then self.read_i16
      when :i32     then self.read_i32
      when :i64     then self.read_i64
      when :i128    then self.read_i128
      when :f32     then self.read_f32
      when :f64     then self.read_f64
      when :string  then self.read_string
      when Array
        case type.first
          when :array   then self.read_array(type[1], type[2])
          when :vector  then self.read_vector(type[1])
          when :map     then self.read_map(type[1], type[2])
          when :set     then self.read_set(type[1])
          when :option  then self.read_option(type[1])
          when :result  then self.read_result(type[1], type[2])
          else raise "unsupported array type specifier: #{type.inspect}"
        end
      when Class
        raise "unsupported class type: #{type}" unless type < Struct
        self.read_struct(type)
      else raise "unsupported type specifier: #{type.inspect}"
    end
  end

  def read_unit
    nil
  end
  alias_method :read_nil, :read_unit

  def read_bool
    self.read_u8 == 1
  end

  def read_u8
    self.read(1).unpack('C').first
  end

  def read_u16
    self.read(2).unpack('v').first
  end

  def read_u32
    self.read(4).unpack('V').first
  end

  def read_u64
    self.read(8).unpack('Q<').first
  end

  def read_u128
    # Read two 64-bit integers (little-endian):
    lower = self.read_u64
    upper = self.read_u64
    # Combine into a 128-bit number:
    (upper << 64) | lower
  end

  def read_i8
    self.read(1).unpack('c').first
  end

  def read_i16
    self.read(2).unpack('s').first
  end

  def read_i32
    self.read(4).unpack('l<').first
  end

  def read_i64
    self.read(8).unpack('q<').first
  end

  def read_i128
    n = self.read_u128
    # Handle two's complement for negative numbers:
    if n >= (1 << 127)
      n - (1 << 128)
    else
      n
    end
  end

  def read_f32
    self.read(4).unpack('e').first
  end

  def read_f64
    self.read(8).unpack('E').first
  end

  def read_string
    self.read(self.read_u32)
  end

  def read_array(element_type, count)
    Array.new(count) { self.read_object(element_type) }
  end

  def read_vector(element_type)
    count = self.read_u32
    self.read_array(element_type, count)
  end
  alias_method :read_vec, :read_vector

  def read_struct(struct_class)
    values = struct_class.members.map { |member|
      type = struct_class::MEMBER_TYPES.fetch(member)
      self.read_object(type)
    }
    struct_class.new(*values)
  end

  def read_enum(variants)
    ordinal = self.read_u8
    type = variants.fetch(ordinal)
    value = self.read_object(type)
    [ordinal, value]
  end

  def read_map(key_type, value_type)
    count = self.read_u32
    result = {}
    count.times do
      key = self.read_object(key_type)
      value = self.read_object(value_type)
      result[key] = value
    end
    result
  end
  alias_method :read_hash, :read_map

  def read_set(element_type)
    count = self.read_u32
    result = Set.new
    count.times do
      result << self.read_object(element_type)
    end
    result
  end

  def read_option(element_type)
    if self.read_bool
      self.read_object(element_type)
    else
      nil
    end
  end

  def read_result(ok_type, err_type)
    ok = self.read_bool
    type = ok ? ok_type : err_type
    value = self.read_object(type)
    [ok, value]
  end
end # Borsh::Readable
