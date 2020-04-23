require "evaluate_file/version"
require "rainbow/ext/string"

module EvaluateFile
  class Error < StandardError; end

  def evaluate_file(path)
    source_code = IO.read(path)
    begin
      instance_eval(source_code, path)
    rescue Exception => e
      if e.class == SystemExit # allow exit to happen normally
        raise
      else
        human_friendly_error(e)
        puts "\nFull error:"
        raise
      end
    end
  end

private
  # Prints out a friendly error message that shows the original line of code
  def human_friendly_error(e)
    error_info = e.backtrace.first
    path, line_no, _ = error_info.split(':')
    line_no = line_no.to_i
    puts "Error evaluating #{path}:".color(:red)
    puts e.message
    puts "Here's the line in #{path} with the error:\n\n"

    contents = IO.read(path)
    content_lines = contents.split("\n")
    context = 5 # lines of context
    top, bottom = [line_no-context-1, 0].max, line_no+context-1
    spacing = content_lines.size.to_s.size
    content_lines[top..bottom].each_with_index do |line_content, index|
      line_number = top+index+1
      if line_number == line_no
        printf("%#{spacing}d %s\n".color(:red), line_number, line_content)
      else
        printf("%#{spacing}d %s\n", line_number, line_content)
      end
    end
  end
end
