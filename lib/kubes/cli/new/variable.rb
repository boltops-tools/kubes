class Kubes::CLI::New
  class Variable < Kubes::CLI::Sequence
    def self.options
      [
        [:force, aliases: ["y"], type: :boolean, desc: "Bypass overwrite are you sure prompt for existing files"],
      ]
    end
    options.each { |args| class_option(*args) }

    def create_helper
      set_source("new/variable")
      file = "#{Kubes.env}.rb"
      template "file.rb", ".kubes/variables/#{file}"
    end
  end
end
