## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram]([Diagrams/NetworkDiagram.png](https://github.com/raospiratory/Project-1---Automated-ELK-Stack-Deployment/tree/main/Diagram))

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Configuration and YAML files may be used to install only certain pieces of it, such as Filebeat.

  - **[Ansible Configuration] (Ansible/ansible.cfg)**
  - **[Hosts] (Ansible/hosts)**
  - **[Elk Installation] (Ansible/install-elk.yml)**
  - **[Filebeat Configuration] (Ansible/filebeat-configuration.yml)**
  - **[Filebeat Playbook] (Ansible/filebeat-playbook.yml)**
  - **[Metricbeat Configuration.yml] (Ansible/metricbeat-configuration.yml)**
  - **[Metricbeat Playbook.yml] (Ansible/metricbeat-playbook.yml)**



This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
- Beats in Use
- Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.
> What aspect of security do load balancers protect?
	* Load balancers are designed to take a load of traffic and distribute it across multiple resources preventing servers to overload.
	* Load balancers play an important role in security by defending against distributed denial-of-service (DDoS) attacks. 
> What is the advantage of a jump box?
	* Jump box virtual machine is exposed on the public network to withstand malicious threats and attacks. It is also used to manage other systems and hardens security, it is treated as a single entryway to a server group from within your security zone. 
	* The advantage of having a jump box is that it limits access to servers that are inaccessible over the network.
	
Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to  
> What does Filebeat watch for?
	* Filebeat monitors the specified log file or location, collects log events, and forwards them to Elasticsearch or Logstash for indexing. 
	* Filebeat is used to collect and send log files. 
	* Filebeat can be installed on almost any operating system, including  Docker containers. It also contains internal modules for specific platforms such as Apache, MySQL,  and Docker, including default configurations and Kibana objects for these platforms.

> What does Metricbeat record?
	* Metricbeat helps monitor your server by collecting metrics and statistics that are collected and sent to the specific from the systems and services running on your server. 
	* Like Filebeat, Metricbeat supports an internal module for collecting statistics from a particular platform. 
	* You can use these modules and a subset called metric sets to configure how often Metricbeat collects metrics and the specific metrics it collects.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

|    Name    |   Function  |        IP Address        | Operating System |          Server         |
|:----------:|:-----------:|:------------------------:|:----------------:|:-----------------------:|
|  Jump Box  |   Gateway   |  104.43.255.56; 10.0.0.1 |       Linux      | Ubuntu Server 18.04 LTS |
|  Web-1 VM  | DVWA Server |         10.0.0.5         |       Linux      | Ubuntu Server 18.04 LTS |
|  Web-2 VM  | DVWA Server |         10.0.0.6         |       Linux      | Ubuntu Server 18.04 LTS |
|  Web-3 VM  | DVWA Server |         10.0.0.7         |       Linux      | Ubuntu Server 18.04 LTS |
| ELK Server |  Monitoring | 20.242.105.231; 10.1.0.7 |       Linux      | Ubuntu Server 18.04 LTS |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Add whitelisted IP addresses: Local Admin, Workstation (My Personal IP)

Machines within the network can only be accessed by Workstation (My IP) and Jump Box Provisioner.
> Which machine did you allow to access your ELK VM?
- Jump Box Provisioner IP: 10.0.0.1 via SSH Port 22 
> What was its IP address?
- Local Admin IP, Workstation (My Personal IP) via port TCP 5601

A summary of the access policies in place can be found in the table below.

|    Name    | Publicly Accessible | Allowed IP Addresses |   Port   |          Server         |
|:----------:|:-------------------:|:--------------------:|:--------:|:-----------------------:|
|  Jump Box  |         Yes         |    Local Admin IP    |  SSH 22  | Ubuntu Server 18.04 LTS |
|  Web-1 VM  |          No         |       10.0.0.5       |  SSH 22  | Ubuntu Server 18.04 LTS |
|  Web-2 VM  |          No         |       10.0.0.6       |  SSH 22  | Ubuntu Server 18.04 LTS |
|  Web-3 VM  |          No         |       10.0.0.7       |  SSH 22  | Ubuntu Server 18.04 LTS |
| Elk Server |          No         |    Local Admin IP    | TCP 5601 | Ubuntu Server 18.04 LTS |


### Elk Configuration [Elk Installation] (Ansible/install-elk.yml)

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
> What is the main advantage of automating configuration with Ansible?
- Ansible is an open source tool with simple configuration management, cloud provisioning and application development. 
- Allows you to deploy YAML playbooks.

<details>
<summary> <b> Click here to view Steps on Creating an ELK Server. </b> </summary>

We will create an ELK server within a virtual network.

###Creating a New vNet

1. Create a new vNet located in the same resouce group you have been using. 
- Make sure this vNet is located in a _new_ region and not the same region as your other VM's.

- Leave the rest of the settings at default.

- Notice, in this example that the IP addressing is automatically created a new network space of `10.1.0.0/16`. If your network is different (10.1.0.0 or 10.3.0.0) it is ok as long as you accept the default settings. Azure automatically creates a network that will work.  

![] (images/elknet1.png)
![] (images/elknet2.png)

2. Create a Peer connection between your vNets. This will allow traffic to pass between you vNets and regions. This peer connection will make both a connection from your first vNet to your second vNet and a reverse connection from your second vNet back to your first vNet. This will allow traffic to pass in both directions.
- Navigate to 'Virtual Network' in the Azure Portal. 

- Select your new vNet to view it's details. 

- Under 'Settings' on the left side, select 'Peerings'.

- Click the `+ Add` button to create a new Peering.

![](images/peerings1.png)

- Make sure your new Peering has the following settings:

	- A unique name of the connection from your new vNet to your old vNet.
		- Elk-to-Red would make sense

	- Choose your original RedTeam vNet in the dropdown labeled 'Virtual Network'. This is the network you are connecting to your new vNet and you should only have one option.

	- Name the resulting connection from your RedTeam Vnet to your Elk vNet.
		- Red-to-Elk would make sense

- Leave all other settings at their defaults.
![](images/peerings2.png)
![](images/peerings3.png)

3. Creating a new VM

- Creating a new Ubuntu VM in your virtual network with the following configures:
- VM must have at least 4GB of RAM. 
- IP address must be same as public IP address.
- The VM must be added to the new region in which you created your new vNet and create a new basic network security group for it.
- After creating the VM make sure that it works by connecting to it from your Jump-box using `ssh username@jump.box.ip`
	```bash
	ssh RedAdmin@jump.box.ip
	```
- Check your Ansible container: `sudo docker ps`
![](images/dockerps.png)
- Locate the container name: `sudo docker container list -a`
![](images/containerlist.png)
- Start the container: `sudo docker container start peaceful_borg`
- Attach the container: `sudo docker attach peaceful_borg`
![](images/sacontainer.png)
- Copy the SSH key from the Ansible container on your jump box: cat ~/.ssh/id_rsa.pub
- Configure a new VM using that SSH key.
![](images/createssh.png)   


</details>
 
The playbook implements the following tasks:
	o Configure ELK VM with Docker
	    ```yaml
       	      - name: Confugre ELK VM with Docker
        	hosts: elk
                remote_user: RedAdmin
                become: true
                tasks:             
      	    ``` 
 	o Install Docker.io
	    ```yaml
       	      - name: Install docker.io
        	apt:
                  update_cache: yes
                  force_apt_get: yes
                  name: docker.io
                  state: present
      	    ``` 
	o Install Python3-pip
	    ```yaml
       	      - name: Install python3-pip
        	apt:
                  force_apt_get: yes
                  name: python3-pip
                  state: present
      	    ``` 
	o Install Docker Python Module
	    ```yaml
       	      - name: Install python3-pip
        	apt:
                  force_apt_get: yes
                  name: python3-pip
                  state: present
      	    ``` 
	o Increase virtual memory
	    ```yaml
       	      - name: Use more memory
        	sysctl:
                  name: vm.max_map_count
       		  value: 262144
      		  state: present
       		  reload: yes
      	    ``` 
	o Download and Launch a Docker ELK Container with ports 5601, 9200, 5044.
	    ```yaml
       	      - name: Download and launch a docker elk container
         	docker_container:
           	  name: elk
           	  image: sebp/elk:761
           	  state: started
           	  restart_policy: always
 		  ports:
          	    - 5601:5601
          	    - 9200:9200
          	    - 5044:5044
      	    ``` 
	o Enable Service Docker on Boot
	    ```yaml
       	      - name: Enable service docker on boot
        	sysmd:
                  name: docker
       		  enabled: yes
      	    ``` 

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 VM: 10.0.0.5
- Web-2 VM: 10.0.0.6
- Web-3 VM: 10.0.0.7

We have installed the following Beats on these machines:
- Filebeat: collects data about the file system.
- Metricbeat: collects machine metrics, such as uptime.

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ELK installation yml file to Ansible container folder /etc/ansible/files/
- Update the hosts file /etc/ansible/hosts to include ELK server IP 10.1.0.7 ![ELK Host] (Images/elkhosts.PNG)
- Run the playbook ansible-playbook install-elk.yml, and navigate to /etc/ansible/ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
