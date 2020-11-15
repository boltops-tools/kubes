describe Kubes::Compiler::Strategy::Dispatcher do
  let(:dispatcher) { described_class.new(options) }
  let(:options) { {path: path } }
  let(:path) { fixture(resource) }

  context "standard" do
    let(:resource) { "project/.kubes/resources/web/deployment" }
    it "run" do
      result = dispatcher.dispatch
      expect(dispatcher.dsl_class(path)).to eq(Kubes::Compiler::Dsl::Syntax::Deployment)
      data = YAML.load(result.content)
      expect(data['kind']).to eq "Deployment"
    end
  end

  context "blocks" do
    let(:resource) { "blocks/deployments" }
    it "run" do
      result = dispatcher.dispatch
      expect(dispatcher.dsl_class(path)).to eq(Kubes::Compiler::Dsl::Core::Blocks)
      resource = result.content.split('---').last
      data = YAML.load(resource)
      expect(data['kind']).to eq "Deployment"
      expect(data['metadata']['name']).to eq "demo-web-2"
    end
  end

  context "multiple files" do
    let(:resource) { "multiple-files/.kubes/resources/web/deployment-1" }
    it "run" do
      result = dispatcher.dispatch
      expect(dispatcher.dsl_class(path)).to eq(Kubes::Compiler::Dsl::Syntax::Deployment)
      data = YAML.load(result.content)
      expect(data['kind']).to eq "Deployment"
    end
  end
end
