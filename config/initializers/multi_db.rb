Rails.application.configure do
  config.active_record.shard_selector = { lock: false }
  config.active_record.shard_resolver = ->(request) {
     subdomain = request.subdomain
    # if subdomain == 'int'
    #   'int'
    # elsif subdomain == 'ext.api.ca-datacenter.dev'
    #   'ext'
    # end
    # tenant = Tenant.find_by_subdomain!(subdomain)
    # tenant.shard
    subdomain
  }
end
