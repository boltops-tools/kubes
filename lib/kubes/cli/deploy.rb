class Kubes::CLI
  class Deploy < Base
    def run
      Build.new(@options).run if build?
      Apply.new(@options).run # also calls Compile
    end
  end
end
