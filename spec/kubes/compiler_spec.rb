describe Kubes::Compile do
  let(:generate) { described_class.new(options) }
  let(:options) { {path: "spec/fixtures/project/.kubes/deployment.rb" } }

  describe "generate" do
    it "run" do
      generate.run
    end
  end
end
