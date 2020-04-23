describe Kubes::Generator do
  let(:generator) { described_class.new(options) }
  let(:options) { {path: "spec/fixtures/project/.kubes/deployment.rb" } }

  describe "generator" do
    it "run" do
      generator.run
    end
  end
end
