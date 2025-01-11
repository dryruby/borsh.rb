require 'borsh'

RSpec.describe Borsh do
  describe 'README examples' do
    it 'roundtrip correctly' do

      ### Writing to an in-memory buffer
      serialized_data = Borsh::Buffer.open do |buf|
        # Primitive types:
        buf.write_bool(true)
        buf.write_u8(255)
        buf.write_i32(-12345)
        buf.write_u128(2**100)
        buf.write_i128(-2**100)
        buf.write_f64(3.14159)
        buf.write_string("Hello, Borsh!")

        # Fixed-size array:
        buf.write_array([1, 2, 3])

        # Dynamic-sized array (array with a length prefix):
        buf.write_vector(['a', 'b', 'c'])

        # Set of integers:
        buf.write_set(Set.new([1, 2, 3]))

        # Map with string keys and integer values:
        buf.write_map({a: 1, b: 2})
      end

      ### Reading from an in-memory buffer
      Borsh::Buffer.new(serialized_data) do |buf|
        # Primitive types:
        expect(buf.read_bool).to eq(true)
        expect(buf.read_u8).to eq(255)
        expect(buf.read_i32).to eq(-12345)
        expect(buf.read_u128).to eq(2**100)
        expect(buf.read_i128).to eq(-2**100)
        expect(buf.read_f64).to eq(3.14159)
        expect(buf.read_string).to eq("Hello, Borsh!")

        # Fixed-size array:
        expect(buf.read_array(:i64, 3)).to eq([1, 2, 3])

        # Dynamic-sized array (array with a length prefix):
        expect(buf.read_vector(:string)).to eq(['a', 'b', 'c'])

        # Set of integers:
        expect(buf.read_set(:i64)).to eq(Set.new([1, 2, 3]))

        # Map with string keys and integer values:
        expect(buf.read_map(:string, :i64)).to eq({'a' => 1, 'b' => 2})
      end
    end
  end
end
