# Processes the ERB files and looks for comments like
#
#     #ERB if @testvar
#     - "some yaml"
#     #ERB end
#
class Kubes::Compiler::Strategy::Erb
  class Comment
    extend Memoist

    def initialize(path)
      @path = path
    end

    def lines
      IO.readlines(@path)
    end
    memoize :lines

    def process?
      !!lines.detect { |l| l.include?('#ERB') }
    end

    def process
      new_lines = lines.map do |line|
        md = line.match(/(.*)#ERB(.*)/)
        if md
          "#{md[1]}<%#{md[2]} %>\n"
        else
          line
        end
      end
      content = new_lines.join('')
      IO.write(erb_path, content)
      erb_path
    end

    def clean
      FileUtils.rm_f(erb_path) unless ENV['KUBES_KEEP_ERB']
    end

    def erb_path
      "#{@path}.erb"
    end
  end
end
