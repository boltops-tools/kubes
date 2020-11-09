class Kubes::CLI
  class New < Kubes::Command
    long_desc Help.text("new/resource")
    Resource.options.each { |args| option(*args) }
    register(Resource, "resource", "resource", "Generates Kubes Kubernetes resource definition.")

    long_desc Help.text("new/helper")
    Helper.options.each { |args| option(*args) }
    register(Helper, "helper", "helper", "Generates kubes helper file.")

    long_desc Help.text("new/variable")
    Variable.options.each { |args| option(*args) }
    register(Variable, "variable", "variable", "Generates kubes variable file.")
  end
end
