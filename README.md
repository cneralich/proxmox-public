## SETUP STEPS

#### 1. Create a Nested-Virtualization-Enabled VM image in GCP
```
gcloud compute disks create disk1 --image-project debian-cloud --image-family debian-9 --zone us-central1-b

gcloud compute images create nested-vm-image-proxmox \
  --source-disk disk1 --source-disk-zone us-central1-b \
  --licenses "https://www.googleapis.com/compute/v1/projects/vm-options/global/licenses/enable-vmx"
```

#### 2. Create a VM from the 'deploy_gcp' folder (using the 'nested-vm-image-proxmox' image created in Step 1)

#### 3. SSH into your GCP VM and follow [these](https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Stretch) install instructions

#### 4. Launch the ProxMox dashboard by visiting https://<external_ip_here>:8006

#### 5. Set the 'api_url', 'user', and 'password' variables in the Workspace you have tied to the 'provision_proxmox' folder and run your 'terraform apply'

#### 6. EXTRA: Apply the 'limit_cores.sentinel' policy to your Workspace
