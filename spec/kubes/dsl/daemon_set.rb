describe Kubes::Compiler::Dsl::Syntax::DaemonSet do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("syntax/daemon_set") } }

  context "DaemonSet" do
    it "run" do
      data = evaluator.run
      expect(data['kind']).to eq "DaemonSet"
    end
  end
end
