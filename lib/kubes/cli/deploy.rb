class Kubes::CLI
  class Deploy < Base
    def run
      Build.new(@options).run
      Apply.new(@options).run # also calls Compile
    end
  end
end
