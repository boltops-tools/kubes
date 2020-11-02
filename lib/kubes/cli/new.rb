class Kubes::CLI
  class New < Sequence
    argument :kind

    def self.options
      [
        [:app, aliases: ["a"], default: "demo", desc: "App name"],
        [:force, aliases: ["y"], type: :boolean, desc: "Bypass overwrite are you sure prompt for existing files"],
        [:role, aliases: ["r"], desc: "Role. IE: web, clock, worker, migrate, etc. Defaults to convention: web or shared when not set"],
        [:type, aliases: ["t"], default: "yaml", desc: "Type: dsl or yaml"],
      ]
    end
    options.each { |args| class_option(*args) }

  private
    def app
      options[:app]
    end

    def role
      role = options[:role]
      return role if role
      shared = %w[
        config_map
        namespace
        network_policy
        persistent_volume
        persistent_volume_claim
        secret
        service_account
      ]
      if shared.include?(full_kind)
        "shared"
      elsif full_kind == "job"
        "migrate"
      else
        "web"
      end
    end

    def full_kind
      # shorthands
      map = {
        cj:     "cron_job",
        cm:     "config_map",
        crd:    "custom_resource_definition",
        crds:   "custom_resource_definition",
        cs:     "component_statuses",
        csr:    "certificate_signing_request",
        deploy: "deployment",
        ds:     "daemonset",
        ep:     "endpoints",
        ev:     "event",
        hpa:    "horizontal_pod_autoscaler",
        ing:    "ingress",
        limits: "limit_range",
        netpol: "network_policy",
        no:     "node",
        ns:     "namespace",
        pc:     "priority_class",
        pdb:    "pod_disruption_budget",
        po:     "pod",
        psp:    "pods_ecurity_policy",
        pv:     "persistent_volume",
        pvc:    "persistent_volume_claim",
        quota:  "resource_quota",
        rc:     "replication_controller",
        rs:     "replica_set",
        sa:     "service_account",
        sc:     "storage_classes",
        sgp:    "security_group_policy",
        sts:    "stateful_set",
        svc:    "service",
      }.stringify_keys!
      map[kind] || kind
    end

    def file
      ext = options[:type] == "yaml" ? "yaml" : "rb"
      "#{full_kind}.#{ext}"
    end

  public
    def set_template_source
      path = File.expand_path("../../templates/new/#{options[:type]}/#{file}", __dir__)
      unless File.exist?(path)
        logger.info "ERROR: Generator for #{file} not supported".color(:red)
        exit 1
      end
      set_source("new/#{options[:type]}")
    end

    def create_resource
      template file, ".kubes/resources/#{role}/#{file}"
    end
  end
end
