# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Enable required GCP APIs.
resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  service  = each.key

  disable_dependent_services = true
}

# Add VPC network.
resource "google_compute_network" "ai_infra" {
  name                    = "ai-infra"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "subnets" {
  for_each      = var.regions
  name          = "subnet-${each.key}"
  network       = google_compute_network.ai_infra.self_link
  region        = each.key
  ip_cidr_range = each.value
}
