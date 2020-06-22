class Kubes::Kubectl
  class Kustomize
    class << self
      extend Memoist

      def detect?
        expr = "#{Kubes.root}/.kubes/resources/**/*"
        !!Dir.glob(expr).detect { |p| p.include?("kustomization.yaml") }
      end
      memoize :detect?
    end
  end
end
