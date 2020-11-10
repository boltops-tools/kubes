class Kubes::CLI
  class Prune < Base
    KINDS = %w[ConfigMap Secret]
    extend Memoist
    include Kubes::Hooks::Concern
    include Kubes::Util::Sure

    def run
      return unless anything_to_prune?
      logger.info "Pruning old resources: #{KINDS.join(', ')}"
      perform(preview: true) unless @options[:yes]
      sure?("This will prune/delete resources. Are you sure?")
      run_hooks("kubes.rb", name: "prune") do
        perform(preview: false)
      end
    end

    def fetcher
      Kubes::Kubectl::Fetch::Base.new(@options)
    end
    memoize :fetcher

    def namespace
      fetcher.namespace
    end

    def anything_to_prune?
      items = []
      return unless namespace

      with_old_items { |i| items << i }
      if items.empty?
        logger.info("There are no old resources that need pruning.") unless @options[:quiet]
      end
      !items.empty?
    end

    def perform(preview:)
      with_old_items do |item|
        prune(item, preview)
      end
    end

    def with_old_items
      items = get_all_items
      items.each do |i|
        next unless old?(i)
        yield(i)
      end
    end

    def old?(item)
      name = item['metadata']['name']
      kind = item['kind']
      built = built_kinds[kind] || [] # IE: {"demo-secret"=>"ebd93b58dd"}
      built.each do |original_name,hash|
        return false unless name.include?(original_name)
        current = "#{original_name}-#{hash}"
        return false if name == current
        # Spec cover the tricky regexp logic
        regexp = Regexp.new("#{original_name}-\\w{10}$") # IE: # demo-secret-\w{10}$
        return true if name.match(regexp)
      end

      false
    end

    def get_all_items
      secrets = capture_items('secret')
      config_maps = capture_items('configmap')
      secrets + config_maps
    end

    def capture_items(kind)
      data = Kubes::Kubectl.capture("get #{kind} -o json -n #{namespace}")
      data['items'] || []
    end

    # IE: {"Secret"=>{"demo-secret"=>"ebd93b58dd"}}
    def built_kinds
      compile # compile so built kinds are in memory
      Kubes::Compiler::Decorator::Hashable::Storage.md5s
    end
    memoize :built_kinds

    def prune(item, preview=false)
      kind = item['kind']
      name = item['metadata']['name']
      args = "delete #{kind} #{name} -n #{namespace}"
      if preview
        logger.info "    kubectl #{args}"
      else
        Kubes::Kubectl.execute(args)
      end
    end
  end
end
