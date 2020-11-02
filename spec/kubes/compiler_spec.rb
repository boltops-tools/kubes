describe Kubes::Compiler do
  let(:compiler) do
    compiler = described_class.new(options)
    allow(compiler).to receive(:write_full)
    compiler
  end
  let(:options) { {path: "spec/fixtures/project/.kubes/resources/web/deployment.rb" } }

  describe "compiler" do
    it "run" do
      compiler.run
    end
  end
end
