describe Kubes::Compiler::Dsl::Syntax::Service do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("services/#{deployment_name}") } }

  context "minimum" do
    let(:deployment_name) { "minimum" }
    it "run" do
      resource = evaluator.run
      data = YAML.load(resource)
      expect(data['spec']['type']).to eq "ClusterIP"
    end
  end
end
