describe Kubes::Compiler do
  let(:compiler) { described_class.new(options) }
  let(:options) { {path: "spec/fixtures/project/.kubes/deployment.rb" } }

  describe "compiler" do
    it "run" do
      compiler.run
    end
  end
end
