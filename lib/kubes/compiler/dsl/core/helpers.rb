module Kubes::Compiler::Dsl::Core
  module Helpers
    def dockerfile_port
      path = "#{Kubes.root}/Dockerfile"
      File.exist?(path) ? parse_for_dockerfile_port(path) : 80
    end

  private
    def parse_for_dockerfile_port(path)
      lines = IO.read(path).split("\n")
      expose_line = lines.find { |l| l =~ /^EXPOSE / }
      if expose_line
        md = expose_line.match(/EXPOSE (\d+)/)
        port = md[1] if md
      end
      port ? port.to_i : 80
    end
  end
end
