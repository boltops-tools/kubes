describe Kubes::CLI do
  describe "kubes" do
    it "generate" do
      out = execute("exe/kubes generate #{@args}")
      # expect(out).to include("from: Tung\nHello world")
    end
  end
end
