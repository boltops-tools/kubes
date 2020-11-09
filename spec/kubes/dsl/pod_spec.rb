describe Kubes::Compiler::Dsl::Syntax::Pod do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("syntax/.kubes/resources/web/pod") } }

  context "pod" do
    it "run" do
      data = evaluator.run
      expect(data['kind']).to eq "Pod"
    end
  end
end
