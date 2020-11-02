module Kubes::Compiler::Shared::Helpers
  class Deprecated
    def built_image
      puts "DEPRECATED: built_image is deprecated, use docker_image helper instead.".color(:yellow)
      print_source
    end

    def error_info
      error_info = caller.find { |l| l.include?('.kubes/resources') }
      path, line_number, _ = error_info.split(':')
      {path: path, line_number: line_number}
    end

    def print_source
      info = error_info
      path = info[:path]
      line_number = info[:line_number].to_i

      pretty_path = path.sub("#{Kubes.root}/",'')
      puts "Here's the line in #{pretty_path} that calls built_image:\n\n"

      contents = IO.read(path)
      content_lines = contents.split("\n")
      context = 5 # lines of context
      top, bottom = [line_number-context-1, 0].max, line_number+context-1
      lpad = content_lines.size.to_s.size
      content_lines[top..bottom].each_with_index do |line_content, index|
        current_line = top+index+1
        if current_line == line_number
          printf("%#{lpad}d %s\n".color(:red), current_line, line_content)
        else
          printf("%#{lpad}d %s\n", current_line, line_content)
        end
      end
    end
  end
end
