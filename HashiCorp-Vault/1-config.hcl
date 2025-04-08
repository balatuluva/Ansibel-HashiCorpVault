disable_cache = true
disable_mlock = true
ui            = true
listener "tcp" {
  address                  = "0.0.0.0:8200"
  tls_disable              = 0
  tls_cert_file            = "/etc/letsencrypt/live/gehana26.fun/fullchain.pem"
  tls_key_file             = "/etc/letsencrypt/live/gehana26.fun/privkey.pem"
  tls_disable_client_certs = "true"

}
storage "file" {
  path = "/var/lib/vault/data"
}
api_addr                = "https://kmsvault.gehana26.fun:8200"
max_lease_ttl           = "10h"
default_lease_ttl       = "10h"
cluster_name            = "vault"
raw_storage_endpoint    = true
disable_sealwrap        = true
disable_printable_check = true