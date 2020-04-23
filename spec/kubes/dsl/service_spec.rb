describe Kubes::Dsl::Service do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("services/#{deployment_name}") } }

  context "minimum" do
    let(:deployment_name) { "minimum" }
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end
end
