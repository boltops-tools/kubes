class Kubes::CLI
  class Init < Sequence
    def self.options
      [
        [:app, aliases: ["a"], required: true, desc: "Docker repo name. Example: web. Generates .kubes/APP/resources folder"],
        [:force, aliases: ["y"], type: :boolean, desc: "Bypass overwrite are you sure prompt for existing files"],
        [:type, aliases: ["t"], default: "yaml", desc: "Type: dsl or yaml"],
        [:repo, required: true, desc: "Docker repo name. Example: user/repo. Configures .kubes/config.rb"],
        [:namespace, aliases: ["n"], desc: "Namespace to use, defaults to APP-ENV. IE: demo-dev"],
      ]
    end

    options.each { |args| class_option(*args) }

  private
    # Needs to be a method to its available for templates/.kubes/resources/%app%
    def app
      @options[:app]
    end

    def namespace
      @options[:namespace] || default_namespace
    end

    def default_namespace
      env = @options[:type] == "yaml" ? '<%= Kubes.env %>' : '#{Kubes.env}'
      "#{app}-#{env}"
    end

    def excludes
      if namespace == "default"
        case options[:type]
        when "dsl"
          %w[
            namespace.rb.tt
          ]
        else
          %w[
            all.yaml.tt
            namespace.yaml.tt
          ]
        end
      else
        []
      end
    end

    def directory_options
      if excludes.empty?
        {}
      else
        pattern = Regexp.new(excludes.join('|'))
        {exclude_pattern: pattern }
      end
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
      directory ".", ".", directory_options
    end

    def create_yaml_files
      return if @options[:type] == "dsl"
      set_source("yaml")
      directory ".", ".", directory_options
    end

    def message
      logger.info "Initialized .kubes folder"
    end

    def adjust_gitignore
      ignores = %w[
        .kubes/output
        .kubes/state
        .kubes/tmp
      ].map {|l| "#{l}\n"} # the readlines will have lines with \n so keep consistent for processing
      if File.exist?(".gitignore")
        lines = IO.readlines(".gitignore")
        if lines.detect { |l| l.include?('.kubes/tmp') }
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
