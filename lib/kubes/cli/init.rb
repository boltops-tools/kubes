class Kubes::CLI
  class Init < Sequence
    def self.options
      [
        [:app, aliases: ["a"], required: true, desc: "Docker repo name. Example: web. Generates .kubes/APP/resources folder"],
        [:force, type: :boolean, desc: "Bypass overwrite are you sure prompt for existing files"],
        [:type, aliases: ["t"], default: "yaml", desc: "Type: dsl or yaml"],
        [:repo, required: true, desc: "Docker repo name. Example: user/repo. Configures .kubes/config.rb"],
      ]
    end

    options.each { |args| class_option(*args) }

  private
    # Needs to be a method to its available for templates/.kubes/resources/%app%
    def app
      @options[:app]
    end

  public
    def create_dockefile
      return if File.exist?("Dockerfile")
      set_source("docker")
      directory ".", "."
    end

    def create_base_files
      set_source("base")
      directory ".", "."
    end

    def create_dsl_files
      return unless @options[:type] == "dsl"
      set_source("dsl")
      directory ".", "."
    end

    def create_yaml_files
      return if @options[:type] == "dsl"
      set_source("yaml")
      directory ".", "."
    end

    def message
      logger.info "Initialized .kubes folder"
    end

    def adjust_gitignore
      ignores = %w[
        .kubes/output
        .kubes/state
      ].map {|l| "#{l}\n"} # the readlines will have lines with \n so keep consistent for processing
      if File.exist?(".gitignore")
        lines = IO.readlines(".gitignore")
        if lines.detect { |l| l.include?('.kubes/output') }
          return # early
        else
          lines += ignores
        end
      else
        lines = ignores
      end

      text = lines.join('')
      IO.write(".gitignore", text)
      puts "Updated .gitignore"
    end
  end
end
