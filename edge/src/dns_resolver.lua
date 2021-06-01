local dns_resolver = {}

dns_resolver.new_master = function(args)
  local master, err = require("resolver.master"):new(args.cache, args.upstream_domain, args.dns_servers)
  if not master then
    error("failed to create hello resolver master: " .. err)
  end
  return master
end

dns_resolver.new_client = function(master)
  master:init()
  local client, err = master:client()
  if not client then
    error("failed to create hello resolver client: " .. err)
  end
  return client
end

dns_resolver.set_address = function(client, options)
  local upstream_address_ip, err = client:get(options.exp_fallback_ok)
  if not upstream_address_ip then
    return false, err
  end

  local ok, err = require("ngx.balancer").set_current_peer(upstream_address_ip, options.port)
  if not ok then
    return false, err
  end

  return true, nil
end

return dns_resolver