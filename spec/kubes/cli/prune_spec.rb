describe Kubes::CLI::Prune do
  let(:prune) do
    prune = described_class.new
    allow(prune).to receive(:sure?)
    allow(prune).to receive(:capture_items).and_return(capture)
    allow(prune).to receive(:logger).and_return(null)
    allow(prune).to receive(:compile).and_return(null) # to avoid building Docker image
    prune
  end
  let(:null) { double(:null).as_null_object }

  let(:fetcher) do
    fetcher = double(:fetcher).as_null_object
    allow(fetcher).to receive(:fetch_items).and_return(fetch_items)
    fetcher
  end
  before(:each) do
    allow(Kubes::Kubectl::Fetch::Base).to receive(:new).and_return(fetcher)
    allow(Kubes::Compiler::Decorator::Hashable::Storage).to receive(:md5s).and_return(built_kinds)
  end

  context("old resources") do
    let(:fetch_items) { fixture("fetch_items.yaml") }
    let(:capture) { fixture("capture.yaml") }
    let(:built_kinds) do
      {"Secret"=>{"demo-secret"=>"CURRENT111"}}
    end

    it "run" do
      allow(Kubes::Kubectl).to receive(:execute)
      prune.run
      expect(Kubes::Kubectl).to have_received(:execute).at_least(:once)
    end
  end

  def fixture(file)
    YAML.load_file("spec/fixtures/prune/#{file}")
  end
end
