class Kubes::Compiler::Strategy::Erb
  class YamlError
    include Kubes::Compiler::Util::SaveFile

    def initialize(path, rendered_yaml)
      @path, @rendered_yaml = path, rendered_yaml
    end

    def show
      FileUtils.mkdir_p(File.dirname(dest))
      IO.write(dest, @rendered_yaml)
      show_error(dest)
    end

    def dest
      save_file = save_file(@path)
      "#{Kubes.root}/.kubes/output/#{save_file}"
    end

    def show_error(path)
      text = IO.read(path)
      begin
        YAML.load(text)
      rescue Psych::SyntaxError => e
        handle_yaml_syntax_error(e, path)
      end
    end

    def handle_yaml_syntax_error(e, path)
      io = StringIO.new
      io.puts "Invalid yaml. Output written for debugging: #{path}".color(:red)
      io.puts "ERROR: #{e.message}".color(:red)

      # Grab line info.  Example error:
      #   ERROR: (<unknown>): could not find expected ':' while scanning a simple key at line 2 column 1
      md = e.message.match(/at line (\d+) column (\d+)/)
      line = md[1].to_i

      lines = IO.read(path).split("\n")
      context = 5 # lines of context
      top, bottom = [line-context-1, 0].max, line+context-1
      spacing = lines.size.to_s.size
      lines[top..bottom].each_with_index do |line_content, index|
        line_number = top+index+1
        if line_number == line
          io.printf("%#{spacing}d %s\n".color(:red), line_number, line_content)
        else
          io.printf("%#{spacing}d %s\n", line_number, line_content)
        end
      end

      if ENV['KUBES_TEST']
        io.string
      else
        puts io.string
        exit 1
      end
    end
  end
end
