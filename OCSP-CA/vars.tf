# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS FOR ALL RESOURCE TYPES - SYSTEM, LOAD BALANCER, SECURITY GROUP
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  region = "${var.aws_region}"
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS FOR ALL RESOURCE TYPES - SYSTEM, LOAD BALANCER, SECURITY GROUP
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "Environment" {
  description = "Environment to target"
  default     = ""
}

variable "env_level" {
  description = "Environment leve: P0 (PROD), P1 (STAGE), P2 (TEST), P3 (DEV)"
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# SYSTEM PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "platform" {
  description = "Platform of OS type"
  default     = ""
}

variable "product" {
  description = "Application context of resource"
  default     = ""
}

variable "huit_assetid" {
  description = "HUIT AssetID"
  default     = ""
}

variable "instance_count" {
  description = "Number of instances to provision"
  default     = ""
}

variable "instance_type" {
  description = "Type of instance to deploy"
  default     = ""
}

variable "key_name" {
  description = "Credential decryption key to use"
  default     = ""
}

variable "ami_id" {
  description = "AMI to use in provisioning"
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GORUP PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "allowed_inbound_client_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections to Active Directory"
  type        = "list"
  default     = []
}

variable "allowed_mgmt_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow SSH connections"
  type        = "list"
  default     = []
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL SECURITY GROUP PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "allowed_inbound_security_group_ids" {
  description = "A list of security group IDs that will be allowed to connect to Active Directory"
  type        = "list"
  default     = []
}

# ---------------------------------------------------------------------------------------------------------------------
# PORTS USED FOR RULES
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "server_dns_port" {
  description = "DNS - User and Computer Authentication, Name Resolution, Trusts"
  default     = 53
}

variable "server_http_port" {
  description = "HTTP TCP Port"
  default     = 80
}

variable "server_krb_port" {
  description = "Kerberos - User and Computer Authentication, Forest Level Trusts"
  default     = 88
}

variable "server_ntp_port" {
  description = "NTP - Windows time, Trusts"
  default     = 123
}

variable "server_epmap_port" {
  description = "EPM Endpoint Mapper , RPC Remote Procedure Call - Replication"
  default     = 135
}

variable "server_netbios_port" {
  description = "NetLogon, NetBIOS Name Resolution - User and Computer Authentication"
  default     = 137
}

variable "server_netbiosdg_port" {
  description = "DFS, Group Policy - DFSN, NetLogon, NetBIOS Datagram Service"
  default     = 138
}

variable "server_netbiosss_port" {
  description = "DFSN, NetBIOS Session Service, NetLogon - User and Computer Authentication, Replication"
  default     = 139
}

variable "server_ldap_port" {
  description = "LDAP - Directory, Replication, User and Computer Auth, Group Policy, Trusts"
  default     = 389
}

variable "server_ldaps_port" {
  description = "LDAPS - Directory, Replication, User and Computer Auth, Group Policy, Trusts from other clients"
  default     = 636
}

variable "server_smb_port" {
  description = "SMB,CIFS,SMB2, DFSN, LSARPC, NbtSS, NetLogonR, SamR, SrvSvc - Replication, User and Computer Authentication, Group Policy, Trusts"
  default     = 445
}

variable "server_https_port" {
  description = "HTTPS TCP Port"
  default     = 443
}

variable "server_krbpw_port" {
  description = "Kerberos - Kerberos Password Set, Change"
  default     = 464
}

variable "server_gc_port" {
  description = "LDAP GC (global catalog) requests - Directory, Replication, User and Computer Authentication, Group Policy, Trusts"
  default     = 3268
}

variable "server_gcssl_port" {
  description = "LDAP GC SSL (global catalog secure) requests - Directory, Replication, User and Computer Authentication, Group Policy, Trusts"
  default     = 3269
}

variable "server_adws_port" {
  description = "ADWS SOAP - AD DS Web Services"
  default     = 9389
}

variable "server_dfsr_port" {
  description = "RPC, DFSR (SYSVOL) - File Replication"
  default     = 5722
}

variable "server_tcpdynamic_low_port" {
  description = "TCP Dynamic RPC, DCOM, EPM, DRSUAPI, NetLogonR, SamR, FRS - Replication, User and Computer Authentication, Group Policy, Trusts"
  default     = 49152
}

variable "server_tcpdynamic_high_port" {
  description = "TCP Dynamic RPC, DCOM, EPM, DRSUAPI, NetLogonR, SamR, FRS - Replication, User and Computer Authentication, Group Policy, Trusts"
  default     = 65535
}
