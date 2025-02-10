# This is free and unencumbered software released into the public domain.

require_relative 'writable'

##
# A byte counter for writing Borsh data.
class Borsh::Sizer
  include Borsh::Writable

  ##
  # @param [String, #to_s, nil] data
  # @yield [buffer]
  # @yieldreturn [Object]
  # @return [String]
  def self.open(data = nil, &block)
    buffer = self.new(data || '', &block)
    buffer.close
    buffer.data
  end

  ##
  # @param [String, #to_s] data
  # @yield [buffer]
  # @yieldreturn [void]
  # @return [void]
  def initialize(data = '', &block)
    @bytesize = data.to_s.bytesize
    @closed = false
    block.call(self) if block_given?
  end

  ##
  # Returns the buffer data.
  #
  # @return [String]
  attr_reader :bytesize

  ##
  # Returns `true` if the buffer is closed.
  #
  # @return [Boolean]
  def closed?; @closed; end

  ##
  # Closes the buffer.
  #
  # @return [void]
  def close; @closed ||= true; end

  ##
  # Writes data to the buffer.
  #
  # @param [String, #to_s] data
  # @return [Integer]
  def write(data)
    @bytesize += data.to_s.bytesize
  end
end # Borsh::Sizer
