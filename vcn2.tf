terraform {
required_providers { 
    oci = { 
      source  = "oracle/oci" 
      version = ">=4.67.3" 
    } 
  } 
  required_version = ">= 1.0.0" 
}

resource "oci_core_vcn" "example_vcn" { 
    compartment_id = var.compartment_id 
    display_name = "IAD-OP-LAB06-1-VCN-01" 
    cidr_blocks = ["10.0.0.0/16"] 
} 

resource "oci_core_subnet" "example_subnet" { 
    compartment_id = var.compartment_id 
    display_name = "IAD-OP-LAB06-1-SNT-01" 
    vcn_id = oci_core_vcn.example_vcn.id 
    cidr_block = "10.0.0.0/24" 
} 
resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = var.availability_domain--ljKK-US-ASHBURN-AD-1
    compartment_id = var.compartment_ocid
    shape = "VM.Standard.A1.Flex"
    shape_config {
    #baseline_ocpu_utilization = ""
    memory_in_gbs             = "6"
    #nvmes                     = "0"
    ocpus                     = "1"
    vcpus                     = "1"
  }
    source_details {
        source_id = var.oci_core_instance--source_details-source_id--export_VM-01
        source_type = "image"
    }

    # Optional
    display_name = "VM-02"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.example_subnet.id
    }
    metadata = {
        ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCj+krouTwVDbTeIv/IntmeMfxrl2ZlvMGQS/6evsKJ1Y6nqv8uTn99ObY9/Eg1u+2IhiuCKecH47HjDa4MAWDKvjglGyL2sSkbiH1D3h0C/ubm7oVpN42Q02tqbp9lLzmzVAPdUJbg7ycH7My20Ko79B4PU/AfEfq2icyExyAbVjddjp7HwTNYUkVrHJo+sYGl3TZPHpuPUpBYnRbilFab6FOLE6uFTZpIOCdc+QCgBIKXI7Z8tJQHsawdTrtHWF6eNVXznbnQgH7uS7hsKAWdW8IaysS7jAXtpy0LxWNXWAKpWRjwibJvUZb0NoV8jIVdtMHEwPVmMGc8DLfazifjhR7vs74o98LrHlcPRpF/w1RwBPZt1aWhUpXMuIIYurFiFeKhOg+VsSRxvL2jfQyiWgnbtlK/ZTHJAlkb9ounvu2ykfJySEkKx0y8W4zR4r7V282a2gKqUhVV+sAYWThHo8LgKcKZIzGPZYQkJwVUMKVljWx6pPFZ/csZ0vnn8csEOwqqU+2xXs0D8rQ1mo1rP79UPxanTBSkCr9FN7ORyqseuXmo0r7+n4mxV0fdYv1qeQWfkTR2nM+TNL4HIyF0GH/yzq1yzNIA8KgXhGg8YOQ9cG7ZgKVLFBEx/0wkRuGpvAq8UYClSPjyQtGexljIlUJEbJjZii0nvPYF38m4rw== x_99069114@d132f9e1f9b7"
    } 
    preserve_boot_volume = false
}