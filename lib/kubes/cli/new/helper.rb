class Kubes::CLI::New
  class Helper < Kubes::CLI::Sequence
    argument :name, default: "custom"

    def self.options
      [
        [:force, aliases: ["y"], type: :boolean, desc: "Bypass overwrite are you sure prompt for existing files"],
      ]
    end
    options.each { |args| class_option(*args) }

  private
    def underscored_name
      name.include?("_helper") ? name : "#{name}_helper"
    end

  public
    def create_helper
      set_source("new/helper")
      file = "#{underscored_name}.rb"
      template "file.rb", ".kubes/helpers/#{file}"
    end
  end
end
