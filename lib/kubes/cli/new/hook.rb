class Kubes::CLI::New
  class Hook < Kubes::CLI::Sequence
    argument :type, default: "kubes", description: "IE: docker, kubectl, kubes" # description doesnt really show up

    def self.options
      [
        [:force, aliases: ["y"], type: :boolean, desc: "Bypass overwrite are you sure prompt for existing files"],
      ]
    end
    options.each { |args| class_option(*args) }

  public
    def create_hook
      set_source("new/hooks")
      template "#{type}.rb", ".kubes/hooks/#{type}.rb"
    end
  end
end
