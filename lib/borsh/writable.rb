# This is free and unencumbered software released into the public domain.

require 'set'

module Borsh::Writable
  def write_object(x)
    x = x.to_borsh if x.respond_to?(:to_borsh)
    case x
      when NilClass   then self.write_unit()
      when FalseClass then self.write_u8(0)
      when TrueClass  then self.write_u8(1)
      when Integer    then self.write_i64(x)
      when Float      then self.write_f64(x)
      when String     then self.write_string(x)
      when Array      then self.write_vector(x)
      when Hash       then self.write_hash_map(x)
      when Set        then self.write_hash_set(x)
      else raise "unsupported type: #{x.class}"
    end
  end

  def write_u8(n)
    self.write([n].pack('C'))
  end

  def write_u16(n)
    self.write([n].pack('v'))
  end

  def write_u32(n)
    self.write([n].pack('V'))
  end

  def write_u64(n)
    self.write([n].pack('Q<'))
  end

  def write_u128(n)
    raise "not implemented yet" # TODO
  end

  def write_i8(n)
    self.write([n].pack('c'))
  end

  def write_i16(n)
    self.write([n].pack('s'))
  end

  def write_i32(n)
    self.write([n].pack('l<'))
  end

  def write_i64(n)
    self.write([n].pack('q<'))
  end

  def write_i128(n)
    raise "not implemented yet" # TODO
  end

  def write_f32(f)
    self.write([f].pack('e'))
  end

  def write_f64(f)
    self.write([f].pack('E'))
  end

  def write_unit()
    # nothing to write
  end

  def write_array(x)
    x.each { |e| e.write_object(self) }
  end

  def write_vector(x)
    self.write_u32(x.size)
    x.each { |e| e.write_object(self) }
  end
  alias_method :write_vec, :write_vector

  def write_struct(x)
    raise "not implemented yet" # TODO
  end

  def write_enum(x)
    raise "not implemented yet" # TODO
  end

  def write_hash_map(x)
    self.write_u32(x.size)
    case x
      when Array
        x.sort.each do |(k, v)|
          self.write_object(k)
          self.write_object(v)
        end
      when Hash
        x.keys.sort.each do |k|
          self.write_object(k)
          self.write_object(x[k])
        end
      else raise "unsupported type: #{x.class}"
    end
  end
  alias_method :write_hash, :write_hash_map

  def write_hash_set(x)
    self.write_u32(x.size)
    keys = case x
      when Array then x
      when Hash then x.keys
      when Set then x.to_a
      else raise "unsupported type: #{x.class}"
    end
    keys.sort.each do |k|
      self.write_object(k)
    end
  end

  def write_option(x)
    if !x.nil?
      self.write_u8(1)
      self.write_object(x)
    else
      self.write_u8(0)
    end
  end

  def write_result(x)
    raise "not implemented yet" # TODO
  end

  def write_string(x)
    self.write_u32(x.bytesize)
    self.write(x)
  end
end # Borsh::Writable
