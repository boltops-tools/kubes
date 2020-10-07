class Kubes::Kubectl
  class Kustomize
    class << self
      extend Memoist

      def detect?
        expr = "#{Kubes.root}/.kubes/resources/**/*"
        !!Dir.glob(expr).detect { |p| p.include?("kustomization.y") } # allow for both .yml and .yaml to work
      end
      memoize :detect?
    end
  end
end
