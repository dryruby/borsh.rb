require 'borsh'

RSpec.describe Borsh do
  it 'roundtrip string with unicode chars' do
    serialized_data = Borsh::Buffer.open do |buf|
      buf.write_string("🙂")
    end

    Borsh::Buffer.new(serialized_data) do |buf|
      expect(buf.read_string).to eq("🙂")
    end
  end
end
