######################
##### KUBERNETES #####
######################
type_project        = "dev"
initial_node_count  = 1
cluster_autoscaling = false
min_nodes_limits    = 1
max_nodes_limits    = 2

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
  }
}


