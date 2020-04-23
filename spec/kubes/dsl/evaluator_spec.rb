describe Kubes::Dsl::Evaluator do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: "spec/fixtures/project/.kubes/deployment.rb" }

  describe "evaluator" do
    it "run" do
      evaluator.run
    end
  end
end
