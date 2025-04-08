resource "random_password" "vm-passwords" {
  count            = 3
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "vault_mount" "siva" {
  path        = "siva"
  type        = "kv-v2"
  description = "This Container siva Family Secrets"
}

resource "vault_mount" "bala" {
  path        = "bala"
  type        = "kv-v2"
  description = "This Container bala Family Secrets"
}


resource "vault_kv_secret_v2" "Prod-secrets" {
  count               = 3
  mount               = vault_mount.siva.path
  name                = "linux-machine-${count.index + 1}"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      username = "adminbala",
      password = element(random_password.vm-passwords.*.result, count.index)
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      foo = "vault@siva.com"
    }
  }
}


#Creating saikiran Secrets
resource "vault_kv_secret_v2" "super-secrets" {
  count               = 3
  mount               = vault_mount.bala.path
  name                = "super-linux-machine-${count.index + 1}"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      username = "adminbala",
      password = element(random_password.vm-passwords.*.result, count.index)
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      foo = "vault@bala.com"
    }
  }
}