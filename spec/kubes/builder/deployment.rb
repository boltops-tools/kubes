describe Kubes::Dsl::Builder do
  let(:builder) { described_class.new(vars) }
  let(:vars) do
    {
      name: "nginx",
      labels: {app: "nginx"},
      namespace: "default",
    }
  end

  describe "builder" do
    it "build" do
      pp builder.build
    end
  end
end
