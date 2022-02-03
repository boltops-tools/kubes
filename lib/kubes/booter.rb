module Kubes
  module Booter
    def boot
      run_hooks
    end

    # Special boot hooks run super early, even before plugins are loaded.
    # Useful for setting env vars and other early things.
    #
    #    config/boot.rb
    #    config/boot/dev.rb
    #
    def run_hooks
      run_hook
      run_hook(Kubes.env)
    end

    def run_hook(env=nil)
      name = env ? "boot/#{env}" : "boot"
      path = "#{Kubes.root}/.kubes/#{name}.rb"
      require path if File.exist?(path)
    end

    extend self
  end
end
