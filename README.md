## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

  `/Diagrams/Azure-Web.png`

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the `filebeat-playbook.yml` file may be used to install only certain pieces of it, such as Filebeat.

  `/Ansible/filebeat-playbook.yml`

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly secure, in addition to restricting traffic to the network.
- Load balancers protect against denial-of-service attacks and provide consistent availability to a server. By triggering a fallback to 
  a different machine, the load balancers can ensure that the server/application stays up. A jump box limits the machines that have access 
  to other machines on the network, this prevents unauthorized access to the network machines. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs.
- Filebeat can be used to analyze and record system logs with relative ease. This data can be collected to monitor any changes or errors in the server. 
- Metricbeat analyzes metric data and is a bit more versatile than Filebeat, it can monitor web traffic, CPU statistics, memory and can also be used to view relevant Docker information. 

The configuration details of each machine may be found below:

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
| Web-1    | App/DVWA | 10.0.0.9   | Linux            |
| Web-2    | App/DVWA | 10.0.0.10  | Linux            |
| Elk      | Analytic | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the DVWA machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 73.202.73.57

Machines within the network can only be accessed by Jump Box.
- The ELK machine can only be accessed by the Ansible docker container with an IP address of `20.124.177.56`

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Private IP          | 73.202.73.57         |
| Web      | No                  | 10.0.0.4             |
| Elk      | No                  | 20.124.177.56        |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Ansible allows the configuration of many machines at once or simply making it easier to add a machine to the pool. 

The playbook implements the following tasks:
- Allowing the VM to use more virtual memory
- Install `docker` and `python3-pip` from APT
- Pull image from repository and deploy
- Enable `docker.service` to make sure it starts on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

/Images/docker-ps.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 10.0.0.9
- Web-2 10.0.0.10

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat allows us to collect logs from the servers so any errors that may occur can recorded and accessed by the administrator. 
- Metricbeat records analytics and statistics such as CPU, memory and traffic. This can be used to manage and oversee the web application.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the `filebeat-playbook.yml` file to `/etc/ansible/`.
- Update the `/etc/ansible/hosts` file to include target IP address. 
- Run the playbook, and navigate to `http://40.78.5.86:5601/app/kibana` to check that the installation worked as expected.

To download the playbook and use you complete the following steps:
- Pull the file from GitHub `wget https://github.com/aethergnos/refactored-octo-umbrella/blob/main/Ansible/filebeat-playbook.yml`
- SSH into Ansible container and edit `hosts` file: `nano /etc/ansible/hosts`
- Navigate to section `[webservers]` to add web-server IP's, then find or add `[elk]` section to add elk-server IP.
- Append IP addresses with the following: `ansible_python_interpreter=/usr/bin/python3`
- Make sure the yml correlates with the targeted machines 
- Deploy the Ansible playbook by running: `ansible-playbook /etc/ansible/filebeat-playbook.yml`
- Check Kibana to make sure that the install worked and machines are being monitored. 
