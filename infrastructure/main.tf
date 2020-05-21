provider "ibm" {
  generation = "1"
  region     = "us-south"
  function_namespace = "mayra.espinoza1@ibm.com_dev"
  bluemix_api_key = "9VjnGiCkH_Xty_aZAmCn5tfZsuFUWQjKjAsydSvyAUpY"
}

resource "ibm_function_action" "nodehello" {
  name = "fademo"
  exec = {
    kind = "nodejs:10"
    code = "${file("index.js")}"
  }
}

data "ibm_resource_group" "group" {
  name = "Eureka"
}

resource "ibm_database" "demodb" {
  name              = "demodb"
  plan              = "standard"
  location          = "us-south"
  service           = "databases-for-postgresql"
  resource_group_id = "${data.ibm_resource_group.group.id}"
  tags              = ["prod"]

  adminpassword     = "AdminDemo2020"
  members_memory_allocation_mb = 2048
  members_disk_allocation_mb   = 10240
  members_cpu_allocation_count = 3
  users = {
          name     = "mparedes"
          password = "PasswordDemo2020"
          }
}