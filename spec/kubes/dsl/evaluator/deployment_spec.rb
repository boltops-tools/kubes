describe Kubes::Dsl::Evaluator::Deployment do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: deployment_fixture(deployment_name) } }

  def deployment_fixture(name)
    "spec/fixtures/deployments/#{name}.rb"
  end

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

  context "setter spec!" do
    let(:deployment_name) { "setter/spec" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end
end
