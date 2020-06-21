describe Kubes::Kubectl::Batch do
  let(:batch) { described_class.new(options) }
  let(:options) { {} }

  describe "batch" do
    let(:files) do
      %w[
        .kubes/output/clock/deployment.yaml
        .kubes/output/web/deployment.yaml
        .kubes/output/web/ingress.yaml
        .kubes/output/web/service.yaml
      ]
    end

    it "sorted_files" do
      allow(batch).to receive(:files).and_return(files)
      expect(batch.sorted_files).to eq(
        [".kubes/output/clock/deployment.yaml",
         ".kubes/output/web/service.yaml",
         ".kubes/output/web/deployment.yaml",
         ".kubes/output/web/ingress.yaml"]) # ingress should be at the end
    end
  end
end
