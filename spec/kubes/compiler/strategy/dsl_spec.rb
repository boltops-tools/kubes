describe Kubes::Compiler::Strategy::Dsl do
  let(:dsl) { described_class.new(options) }
  let(:options) { {path: fixture(resource) } }

  context "standard" do
    let(:resource) { "project/.kubes/resources/deployment" }
    it "run" do
      result = dsl.run
      expect(dsl.dsl_class).to eq(Kubes::Compiler::Dsl::Syntax::Deployment)
      data = YAML.load(result.content)
      expect(data['kind']).to eq "Deployment"
    end
  end

  context "blocks" do
    let(:resource) { "blocks/deployments" }
    it "run" do
      result = dsl.run
      expect(dsl.dsl_class).to eq(Kubes::Compiler::Dsl::Core::Blocks)
      resource = result.content.split('---').last
      data = YAML.load(resource)
      expect(data['kind']).to eq "Deployment"
      expect(data['metadata']['name']).to eq "demo-web-2"
    end
  end

  context "multiple files" do
    let(:resource) { "multiple-files/deployment-1" }
    it "run" do
      result = dsl.run
      expect(dsl.dsl_class).to eq(Kubes::Compiler::Dsl::Syntax::Deployment)
      data = YAML.load(result.content)
      expect(data['kind']).to eq "Deployment"
    end
  end
end
