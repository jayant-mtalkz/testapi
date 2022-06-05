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
