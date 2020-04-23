describe Kubes::Dsl::Evaluator::Deployment do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("deployments/#{deployment_name}") } }

  context "minimum" do
    let(:deployment_name) { "minimum" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end

  context "additional props" do
    let(:deployment_name) { "props" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end

  context "setter container!" do
    let(:deployment_name) { "setter/container" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end

  context "setter sidecar!" do
    let(:deployment_name) { "setter/sidecar" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end

  context "setter containers!" do
    let(:deployment_name) { "setter/containers" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end

  context "setter spec!" do
    let(:deployment_name) { "setter/spec" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end
end
