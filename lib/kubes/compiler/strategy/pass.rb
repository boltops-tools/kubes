class Kubes::Compiler::Strategy
  class Pass < Base
    def run
      # use filehandle instead of content. write is aware of this and handles properly
      io = File.read(@path)
      Result.new(@save_file, io)
    end
  end
end
