

variable "ibmcloud_api_key" {
  description = "Enter your IBM Cloud API Key, you can get your IBM Cloud API key using: https://console.bluemix.net/iam#/apikeys"

}

provider "ibm" {
  ibmcloud_api_key    = "${var.bluemix_api_key}"
}
