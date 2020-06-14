describe Kubes::CLI do
  describe "kubes" do
    it "generate" do
      out = execute("exe/kubes compile #{@args}")
      # expect(out).to include("from: Tung\nHello world")
    end
  end
end
