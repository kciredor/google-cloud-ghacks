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
variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID to create resources in."
}

# Default value passed in
variable "gcp_region" {
  type        = string
  description = "Region to create resources in."
  default     = "us-central1"
}

# Default value passed in
variable "gcp_zone" {
  type        = string
  description = "Zone to create resources in."
  default     = "us-central1-c"
}

# GCP services to be enabled.
variable "gcp_service_list" {
  type = list(string)
  default = [
    "compute.googleapis.com",
    # "tpu.googleapis.com",
  ]
}

# Regions to be used including VPC subnet creation.
variable "regions" {
  type = map(string)
  default = {
    "us-central1" = "10.0.0.0/24",
    "us-east1"    = "10.0.1.0/24",
  }
}
