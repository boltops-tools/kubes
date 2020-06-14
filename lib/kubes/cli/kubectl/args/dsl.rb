module Kubes::CLI::Kubectl::Args
  module Dsl
    def command(*commands, **props)
      commands.each do |name|
        each_command(name, props)
      end
    end
    alias_method :commands, :command

    def each_command(name, props={})
      @commands[name.to_s] = props
    end
  end
end
