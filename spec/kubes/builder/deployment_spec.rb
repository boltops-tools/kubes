describe Kubes::Builder::Deployment do
  let(:builder) { described_class.new(vars) }
  let(:minimum_vars) do
    {
      name: "nginx",
      labels: {app: "nginx"},
      namespace: "default",
    }
  end

  context "minimum vars" do
    let(:vars) { minimum_vars }
    describe "builder" do
      it "build" do
        puts YAML.dump(builder.build)
      end
    end
  end

  context "containers var also" do
    let(:vars) do
      minimum_vars.merge(
        containers: [
          name: "nginx",
          image: "nginx",
          ports: [containerPort: 80]
        ]
      )
    end
    describe "builder" do
      it "build" do
        puts YAML.dump(builder.build)
      end
    end
  end
end
