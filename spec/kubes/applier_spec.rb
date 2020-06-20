describe Kubes::Applier do
  let(:applier) { described_class.new(options) }
  let(:options) { {} }

  describe "applier" do
    let(:files) do
      %w[
        .kubes/output/demo-clock/deployment.yaml
        .kubes/output/demo-web/deployment.yaml
        .kubes/output/demo-web/ingress.yaml
        .kubes/output/demo-web/service.yaml
      ]
    end

    it "sorted_files" do
      allow(applier).to receive(:files).and_return(files)
      expect(applier.sorted_files).to eq(
        [".kubes/output/demo-clock/deployment.yaml",
         ".kubes/output/demo-web/deployment.yaml",
         ".kubes/output/demo-web/service.yaml",
         ".kubes/output/demo-web/ingress.yaml"]) # ingress should be at the end
    end
  end
end
