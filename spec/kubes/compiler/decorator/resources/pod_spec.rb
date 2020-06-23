describe Kubes::Compiler::Decorator::Resources::Pod do
  let(:decorator) { described_class.new(data) }

  def fixture(name)
    YAML.load_file("spec/fixtures/decorators/pod/#{name}.yaml")
  end
  before(:each) do
    allow(Kubes::Compiler::Decorator).to receive(:fetch).and_return("fakehash")
  end

  context("secret") do
    context "envFrom" do
      let(:data) { fixture("secret/envFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['containers'][0]['envFrom'][0]['secretRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "valueFrom" do
      let(:data) { fixture("secret/valueFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['containers'][0]['env'][0]['valueFrom']['secretKeyRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "volumes" do
      let(:data) { fixture("secret/volumes") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['volumes'][0]['secret']['secretName']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "run" do
      let(:data) { fixture("secret/envFrom") }
      it "data" do
        decorator.run
        name = data['spec']['containers'][0]['envFrom'][0]['secretRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end
  end

  context "configMap" do
    context "envFrom" do
      let(:data) { fixture("configMap/envFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['containers'][0]['envFrom'][0]['configMapRef']['name']
        expect(name).to eq("demo-config-map-fakehash")
      end
    end

    describe "valueFrom" do
      let(:data) { fixture("configMap/valueFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['containers'][0]['env'][0]['valueFrom']['configMapKeyRef']['name']
        expect(name).to eq("demo-config-map-fakehash")
      end
    end

    describe "volumes" do
      let(:data) { fixture("configMap/volumes") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['volumes'][0]['configMap']['name']
        expect(name).to eq("demo-config-map-fakehash")
      end
    end

    describe "run" do
      let(:data) { fixture("configMap/envFrom") }
      it "data" do
        decorator.run
        name = data['spec']['containers'][0]['envFrom'][0]['configMapRef']['name']
        expect(name).to eq("demo-config-map-fakehash")
      end
    end
  end
end
