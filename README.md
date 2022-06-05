## Assignment

### Prerequites

* Git
* Python3

# Terraform

Install the terraform for provisioning the resources by AWS.
```
git clone https://github.com/jayant-mtalkz/testapi.git
python3 ./install/terraform.py
```
### Configure AWS Command Line using Security Credentials
* Go to AWS Management Console --> Services --> IAM --> User --> Select user : mtalkz

* Click on Security credentials tab

* Click on Create access key

* Copy Access ID and Secret access key

* Go to command line and use ``aws configure``

```
$ aws configure

AWS Access Key ID [None]: ABCDEFGxxxxx  (Replace your creds when prompted)
AWS Secret Access Key [None]: xxxxxxxxxxx  (Replace your creds when prompted)
Default region name [None]: us-east-1
Default output format [None]: json
```
## Provision EKS
Install kubectl CLI
```
cd ./install/
python3 kubectl.py
``` 

Go inside ``terraform/eks/`` and provision the EKS.
```
cd ./terraform/eks/
terraform init
terraform plan
terraform apply --auto-approve
```
## Provision Jenkins server

Jenkins is used for CI/CD here.
```
cd ./terraform/jenkins/
terraform init 
terraform plan
terraform apply --auto-approve
```


# Jenkins Server
## Install Java
The installation of OpenJDK from standard repositories is recommended. Open and enter the following in the terminal window:
```
sudo apt update 
sudo apt install openjdk-8-jdk 
```

## Install Jenkins
Add the framework repository key  
```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add
```
Next, link the repository of Debian packages to the sources.list of the server

```
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' 
```
When both are in place, upgrade to apt to use the new repository: 

```
sudo apt update
```
Install Jenkins
```
sudo apt install jenkins 
```
###  Start Jenkins 
start Jenkins using systemctl
```
systemctl enable jenkins --now
```
As systemctl does not display performance, you can use the status command to check that Jenkins has successfully launched:
```
systemctl status jenkins
```
### Setting Up Jenkins
To set up installation, visit Jenkins on its default 8080 port with your server domain name or IP address: ``http://your_server_ip_or_domain:8080 ``


Use the cat command to display the password: 
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword 
```
Copy the alphanumeric terminal 32-character password and paste into the Administrator Password field, then click Continue. 



