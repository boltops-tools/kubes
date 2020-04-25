RSpec.describe HashSqueezer do
  let(:squeezer){ described_class.new }
  it "has a version number" do
    expect(HashSqueezer::VERSION).not_to be nil
  end

  context("filled") do
    let(:data) { {a: 1, b: 1} }
    it "squeeze" do
      result = squeezer.squeeze(data)
      expect(result).to eq({a: 1, b: 1})
    end
  end

  context("empty") do
    let(:data) { {a: nil, b: [], c: {} } }
    it "squeeze" do
      result = squeezer.squeeze(data)
      expect(result).to eq({})
    end
  end

  context("nested empty values") do
    let(:data) { {a: {b: {c: nil}}} }
    it "squeeze" do
      result = squeezer.squeeze(data)
      expect(result).to eq({})
    end
  end
end
