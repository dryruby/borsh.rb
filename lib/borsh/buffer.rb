# This is free and unencumbered software released into the public domain.

require 'stringio'
require_relative 'readable'
require_relative 'writable'

##
# A buffer for reading and writing Borsh data.
class Borsh::Buffer
  include Borsh::Readable
  include Borsh::Writable

  ##
  # @param [String, nil] data
  # @yield [buffer]
  # @yieldreturn [Object]
  # @return [String]
  def self.open(data = nil, &block)
    buffer = self.new(data || '', &block)
    buffer.close
    buffer.data
  end

  ##
  # @param [String] data
  # @yield [buffer]
  # @yieldreturn [void]
  # @return [void]
  def initialize(data = '', &block)
    @buffer = StringIO.new(data)
    @buffer.binmode
    block.call(self) if block_given?
  end

  ##
  # Returns the buffer data.
  #
  # @return [String]
  def data
    @buffer.string
  end
  alias_method :string, :data

  ##
  # Returns `true` if the buffer is closed.
  #
  # @return [Boolean]
  def closed?
    @buffer.closed?
  end

  ##
  # Closes the buffer.
  #
  # @return [void]
  def close;
    @buffer.close
  end

  ##
  # Reads the specified number of bytes from the buffer.
  #
  # @param [Integer, #to_i] length
  # @return [String]
  def read(length)
    @buffer.read(length.to_i)
  end

  ##
  # Writes data to the buffer.
  #
  # @param [String, #to_s] data
  # @return [Integer]
  def write(data)
    @buffer.write(data.to_s)
  end
end # Borsh::Buffer
