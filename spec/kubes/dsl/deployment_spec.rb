describe Kubes::Compiler::Dsl::Syntax::Deployment do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("deployments/#{deployment_name}") } }

  context "minimum" do
    let(:deployment_name) { "minimum" }
    it "run" do
      data = evaluator.run
      expect(data['spec']).not_to be nil
    end
  end

  context "additional props" do
    let(:deployment_name) { "props" }
    it "run" do
      data = evaluator.run
      expect(data['spec']).not_to be nil
    end
  end

  context "setter metadata!" do
    let(:deployment_name) { "setter/metadata" }
    it "run" do
      data = evaluator.run
      expect(data['spec']['replicas']).to eq 3
    end
  end

  context "setter spec!" do
    let(:deployment_name) { "setter/spec" }
    it "run" do
      data = evaluator.run
      expect(data['spec']).not_to be nil
    end
  end

  context "setter container!" do
    let(:deployment_name) { "setter/container" }
    it "run" do
      data = evaluator.run
      expect(data['spec']).not_to be nil
    end
  end

  context "setter sidecar!" do
    let(:deployment_name) { "setter/sidecar" }
    it "run" do
      data = evaluator.run
      expect(data['spec']).not_to be nil
    end
  end

  context "setter containers!" do
    let(:deployment_name) { "setter/containers" }
    it "run" do
      data = evaluator.run
      expect(data['spec']).not_to be nil
    end
  end
end
