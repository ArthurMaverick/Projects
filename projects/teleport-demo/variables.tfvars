######################
##### PROJECTNAME #####
######################
project_name = "labs"

######################
##### KUBERNETES #####
######################
initial_node_count  = 1
min_nodes_limits    = 1
max_nodes_limits    = 2
cluster_autoscaling = false

######################
####### ROLES ########
######################
role_config = {
  storage_bucket_creator = {
    role_id     = "storageBucketCreator"
    title       = "storage-bucket-creator-role"
    description = "Role granting storage.buckets.create"
    permissions = ["storage.buckets.create"]
  },
  dns_update_role = {
    role_id     = "dnsUpdateRole"
    title       = "dns-update-role"
    description = "Role granting Cloud Dns update permissions"
    permissions = [
      "dns.resourceRecordSets.create", 
      "dns.resourceRecordSets.delete", 
      "dns.resourceRecordSets.list", 
      "dns.resourceRecordSets.update", 
      "dns.changes.create", 
      "dns.changes.get", 
      "dns.changes.list", 
      "dns.managedZones.list"
    ]
  },

}

######################
### SERVICECCOUNT ####
######################
service_account_name = "teleport-helm"
display_name         = ""
account_id           = "teleport-helm"
description          = "Service account for Teleport Helm Chart"

default_role_bind     = {
  datastore_owner = {
    role_bind     = "roles/datastore.owner"
  },
  storage_object_creator = {
    role_bind            = "roles/storage.objectCreator"
  }
  storage_object_viewer = {
    role_bind           = "roles/storage.objectViewer"
  }
}