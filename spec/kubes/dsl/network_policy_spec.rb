describe Kubes::Compiler::Dsl::Syntax::NetworkPolicy do
  let(:evaluator) { described_class.new(options) }
  let(:options) { {path: fixture("syntax/network_policy") } }

  context "network_policy" do
    it "run" do
      data = evaluator.run
      expect(data['kind']).to eq "NetworkPolicy"
      # fromMatchLabels
      from = data['spec']['ingress'].first['from'].first
      expect(from['podSelector']['matchLabels']['run']).to eq "tester"
    end
  end
end
