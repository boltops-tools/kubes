describe Kubes::Compiler::Decorator::Post do
  let(:decorator) { described_class.new(data) }

  def fixture(name)
    YAML.load_file("spec/fixtures/decorators/deployment/#{name}.yaml")
  end
  before(:each) do
    allow(Kubes::Compiler::Decorator::Hashable::Storage).to receive(:fetch).and_return("fakehash")
    allow(Kubes::Compiler::Decorator::Hashable::Storage).to receive(:fetch).with("Secret", "demo-secret").and_return("fakehash")
    allow(Kubes::Compiler::Decorator::Hashable::Storage).to receive(:fetch).with("ConfigMap", "demo-config-map").and_return("fakehash-config")
    allow(Kubes::Compiler::Decorator::Hashable::Storage).to receive(:fetch).with("ConfigMap", "demo-config-map-2").and_return("fakehash-config2")
  end

  context "secret" do
    describe "envFrom" do
      let(:data) { fixture("secret/envFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['template']['spec']['containers'][0]['envFrom'][0]['secretRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "valueFrom" do
      let(:data) { fixture("secret/valueFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['template']['spec']['containers'][0]['env'][0]['valueFrom']['secretKeyRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "volumes" do
      let(:data) { fixture("secret/volumes") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['template']['spec']['volumes'][0]['secret']['secretName']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "run" do
      let(:data) { fixture("secret/envFrom") }
      it "data" do
        decorator.run
        name = data['spec']['template']['spec']['containers'][0]['envFrom'][0]['secretRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end
  end

  context "configMap" do
    describe "envFrom" do
      let(:data) { fixture("configMap/envFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['template']['spec']['containers'][0]['envFrom'][0]['configMapRef']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
      end
    end

    describe "valueFrom" do
      let(:data) { fixture("configMap/valueFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['template']['spec']['containers'][0]['env'][0]['valueFrom']['configMapKeyRef']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
      end
    end

    describe "volumes" do
      let(:data) { fixture("configMap/volumes") }
      it "run" do
        decorator.run
        data = decorator.data
        name = data['spec']['template']['spec']['volumes'][0]['configMap']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
      end
    end

    describe "run" do
      let(:data) { fixture("configMap/envFrom") }
      it "data" do
        decorator.run
        name = data['spec']['template']['spec']['containers'][0]['envFrom'][0]['configMapRef']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
      end
    end
  end

  context "both" do
    describe "envFrom" do
      let(:data) { fixture("both/envFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        envFrom = data['spec']['template']['spec']['containers'][0]['envFrom']
        name = envFrom[0]['secretRef']['name']
        expect(name).to eq("demo-secret-fakehash")
        name = envFrom[1]['configMapRef']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
        name = envFrom[2]['configMapRef']['name']
        expect(name).to eq("demo-config-map-2-fakehash-config2")
      end
    end

    describe "valueFrom" do
      let(:data) { fixture("both/valueFrom") }
      it "run" do
        decorator.run
        data = decorator.data
        valueFrom = data['spec']['template']['spec']['containers'][0]['env'][0]['valueFrom']
        name = valueFrom['configMapKeyRef']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
        name = valueFrom['secretKeyRef']['name']
        expect(name).to eq("demo-secret-fakehash")
      end
    end

    describe "volumes" do
      let(:data) { fixture("both/volumes") }
      it "run" do
        decorator.run
        data = decorator.data
        volumes = data['spec']['template']['spec']['volumes']
        name = volumes[0]['configMap']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
        name = volumes[1]['secret']['secretName']
        expect(name).to eq("demo-secret-fakehash")
      end
    end
  end

  context "order" do
    # spec to fix issue https://github.com/boltops-tools/kubes/issues/49
    describe "name first" do
      let(:data) { fixture("configMap/volumes-name-first") }
      it "run" do
        decorator.run
        data = decorator.data
        volumes = data['volumes']
        name = volumes[0]['configMap']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
      end
    end

    describe "name second" do
      let(:data) { fixture("configMap/volumes-name-second") }
      it "run" do
        decorator.run
        data = decorator.data
        volumes = data['volumes']
        name = volumes[0]['configMap']['name']
        expect(name).to eq("demo-config-map-fakehash-config")
      end
    end
  end
end
