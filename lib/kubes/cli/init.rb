class Kubes::CLI
  class Init < Sequence
    def self.options
      [
        [:app, aliases: ["a"], required: true, desc: "Docker repo name. Example: demo-web. Generates .kubes/APP/resources folder"],
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
    def already_init_check
      return unless File.exist?(".kubes")
      logger.info <<~EOL
        Theres already an .kubes folder. This project has already been initialized by kubes.
        Delete the .kubes folder and run again if you want to reinitialize.
      EOL
      exit
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
      ]
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

      text = lines.join("\n") + "\n"
      IO.write(".gitignore", text)
      puts "Updated .gitignore"
    end
  end
end
