variable "virgina_cidr" {
  description = "CIDR Virginia"
  type        = string
  sensitive   = false

}

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

# variable "public_subnet" {
#   description = "CIDR public subnet"
#   type = string
# }

# variable "private_subnet" {
#   description = "CIDR private subnet"
#   type = string
# }

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)
}


variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type = map(string)
}

variable "palabras" {
  type = list(string)
  default = [ "hola", "como", "estas" ]
}

variable "cadena" {
  type = string
  default = "ami-123, AMI-AAV,ami-12f"
}

variable "entornos" {
  type = map(string)
  default = {
    "prod" = "10.10.0.0/16"  }
}

variable "enable_monitoring" {
  description = "Habilita el despliegue de un servidor de monitoreo"
  type = number
}

variable "ingress_ports_list" {
  description = "Lista de puertos de ingress"
  type = list(number)
}
