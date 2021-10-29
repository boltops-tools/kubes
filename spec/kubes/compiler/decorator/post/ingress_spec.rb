describe Kubes::Compiler::Decorator::Post do
  let(:decorator) { described_class.new(data) }

  def fixture(name)
    YAML.load_file("spec/fixtures/decorators/ingress/#{name}.yaml")
  end
  before(:each) do
    allow(Kubes::Compiler::Decorator::Hashable::Storage).to receive(:fetch).and_return("fakehash")
  end

  context "ingress" do
    describe "tls" do
      let(:data) { fixture("tls") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['tls'][0]['secretName']
        expect(name).to eq("tls-secret-fakehash")
      end
    end
  end
end
