describe Kubes::Dsl::Evaluator::Deployment do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: "spec/fixtures/project/.kubes/deployment.rb" } }

  describe "evaluator" do
    it "run" do
      resource = evaluator.run
      puts YAML.dump(resource)
    end
  end
end
