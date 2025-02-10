# This is free and unencumbered software released into the public domain.

require_relative 'writable'

##
# A byte counter for writing Borsh data.
class Borsh::Sizer
  include Borsh::Writable

  ##
  # @yield [buffer]
  # @yieldparam [Borsh::Sizer] buffer
  # @yieldreturn [void]
  # @return [Integer]
  def self.open(&block)
    buffer = self.new(&block)
    buffer.close
    buffer.bytesize
  end

  ##
  # @yield [buffer]
  # @yieldparam [Borsh::Sizer] buffer
  # @yieldreturn [void]
  # @return [void]
  def initialize(&block)
    self.reset!
    block.call(self) if block_given?
  end

  ##
  # Returns the buffer size in bytes.
  #
  # @return [Integer]
  attr_reader :bytesize
  alias_method :size, :bytesize

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
    raise IOError, "closed stream" if self.closed?
    @bytesize += data.to_s.bytesize
  end

  ##
  # @return [Integer]
  def reset!
    result = @bytesize
    @bytesize, @closed = 0, false
    result
  end
end # Borsh::Sizer
