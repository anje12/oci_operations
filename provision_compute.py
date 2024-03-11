import oci 
 
# Load your tenancy, user, etc. information 
config = oci.config.from_file() 
 
# Variables to fill in 
compartment_id = "ocid1.compartment.oc1..aaaaaaaaiugoxedsjbk7kyvu724jaa6khknzvbtu5fdwftwbcfqbbve2i5ga" 
image_id = "ocid1.image.oc1.iad.aaaaaaaabta3gqhlfoam3l7rayd4inr6hhg4cmvcqb7p43qadkiehnszyuka" 
subnet_id = "ocid1.subnet.oc1.iad.aaaaaaaarjutobbu25y345sw6f3hwuqpxpisobefubcpprrne6fyggqkkehq" 
display_name = "VM-3"
 
# Get first availability domain name 
iam = oci.identity.IdentityClient(config) 
availability_domain = iam.list_availability_domains(compartment_id).data[0].name 
 
# Package all settings together 
launch_instance_details = oci.core.models.LaunchInstanceDetails( 
    availability_domain=availability_domain,
compartment_id=compartment_id, 
    display_name=display_name, 
    shape="VM.Standard.A1.Flex", 
    shape_config=oci.core.models.LaunchInstanceShapeConfigDetails( 
        ocpus=1, memory_in_gbs=6), 
    source_details=oci.core.models.InstanceSourceViaImageDetails( 
        image_id=image_id, source_type="image"), 
create_vnic_details=oci.core.models.CreateVnicDetails( 
        assign_public_ip=True, subnet_id=subnet_id) 
) 
 
# Launch compute instance 
compute = oci.core.ComputeClient(config) 
compute.launch_instance(launch_instance_details)