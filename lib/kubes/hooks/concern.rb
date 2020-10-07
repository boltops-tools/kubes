module Kubes::Hooks
  module Concern
    # options example: {:name=>"apply", :file=>".kubes/output/web/service.yaml"}
    def run_hooks(file, options={}, &block)
      hooks = Kubes::Hooks::Builder.new("#{Kubes.root}/.kubes/config/hooks/#{file}", options)
      hooks.build # build hooks
      hooks.run_hooks(&block)
    end
  end
end
