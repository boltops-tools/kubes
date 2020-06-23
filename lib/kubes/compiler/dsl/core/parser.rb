module Kubes::Compiler::Dsl::Core
  class Parser
    def initialize(path)
      @path = path
    end

    def parse
      contents = IO.read(@path)
      lines = parse_contents(contents)

      # First use a Hash structure so that overlay env files will override
      # the base param file.
      data = {}
      lines.each do |line|
        key,value = line.strip.split("=").map {|x| x.strip}
        value = remove_surrounding_quotes(value)
        data[key] = value
      end
      data
    end

    def parse_contents(contents)
      lines = contents.split("\n")
      # remove comment at the end of the line
      lines.map! { |l| l.sub(/#.*/,'').strip }
      # filter out commented lines
      lines = lines.reject { |l| l =~ /(^|\s)#/i }
      # filter out empty lines
      lines = lines.reject { |l| l.strip.empty? }
      lines
    end

    def remove_surrounding_quotes(s)
      if s =~ /^"/ && s =~ /"$/
        s.sub(/^["]/, '').gsub(/["]$/,'') # remove surrounding double quotes
      elsif s =~ /^'/ && s =~ /'$/
        s.sub(/^[']/, '').gsub(/[']$/,'') # remove surrounding single quotes
      else
        s
      end
    end
  end
end
