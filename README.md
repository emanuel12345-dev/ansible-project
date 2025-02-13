# Ansible and Terraform Infrastructure Deployment Project

## Prerequisites

### Tools and Software
- Terraform 
- azure subscription
- Azure CLI
- PowerShell 


## Introduction
"This project automates the deployment and configuration of infrastructure on Azure by integrating Terraform and Ansible. Terraform deploys one Linux machine and two Windows machines across different regions and virtual networks, connecting them via global VNet peering. Once the VMs are created, Ansible is used for post-provisioning configuration management. Ansible scripts install essential packages on the Windows VMs, such as the .NET Framework, Python, and Docker Desktop, ensuring a consistent, reproducible, and scalable environment while minimizing manual intervention and configuration drift."

![Multi-Region Infrastructure Diagram]([C:\Users\emanu\OneDrive\Desktop\projects for github\ansible project\multi-region-infrastructure.png](https://github.com/emanuel12345-dev/ansible-project/blob/e1f84ac9ce380bfd8f49abffc3760155f67f0732/multi-region-infrastructure.png))

### Key Features

- **Automated Provisioning:** Infrastructure is deployed using Terraform.
- **WinRM over HTTPS:** Windows VMs are configured with secure WinRM (port 5986) for remote management.
- **Software Installation via Ansible:** .NET Framework 4.8, Python, and Docker Desktop are installed using Ansible and Chocolatey.
- **Reproducibility:** Consistent environment setup across teams.
- **Modularity:** Terraform code is organized into reusable modules.

### Infrastructure Benefits

- **Automation:** Complete environment setup using Infrastructure as Code (Terraform & Ansible).
- **Reproducibility:** Consistent development environment across team members.
- **Security:** Properly configured NSG rules and secure WinRM connectivity.
- **Modularity:** Terraform modules and Ansible playbooks simplify customization and maintenance.

## Infrastructure Components

- **Resource Group:** Contains all deployed resources.
- **Virtual Network & Subnet:** Provides connectivity between VMs.
- **Network Security Group:** Controls inbound/outbound traffic (including RDP and WinRM on port 5986).
- **Virtual Machines:**
  - **Linux VM:** Acts as the Ansible control node.
  - **Windows VMs:** Configured with WinRM, .NET Framework 4.8, Python, and Docker Desktop.


## Infrastructure Deployment

### 1. Azure Authentication

Log in to your Azure account using the Azure CLI:

```bash
az login
```

### 2. Terraform Infrastructure Deployment

1. **Initialize the Terraform working directory**:

   ```bash
   terraform init
   ```

2. **Generate and review the execution plan**:

   ```bash
   terraform plan
   ```

3. **Apply the Terraform plan** to deploy the infrastructure:

   ```bash
   terraform apply
   ```

### 3. After the infrastructure is provisioned with Terraform, configure the VMs using Ansible:


1. **Configure WinRM on Windows VMs:**

   On each Windows VM, run the PowerShell script to set up WinRM over HTTPS:

```powershell
.\configure-winrm.ps1
```

2. **Prepare Ansible Files:**

   Make sure the inventory file (`hosts.ini`) and the main playbook (`install.yml`) are available on the Linux VM used as the Ansible control node.

3. **Run the Ansible Playbook:**

   ```bash
   ansible-playbook -i hosts.ini install.yaml
   ```



## Clean Up
To remove all created resources, run:

   ```bash
   terraform destroy
   ```
