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


## Dockerize a Flask Application
Basic directory structure
```
app
├── app.py
├── Dockerfile
├── requirements.txt
└── venv
```
Build a Docker Image
```
docker build -t hackcoderr/flask .
```


## CI/CD for Build and Publish Docker image

Created pipeline for CI/CD on jenkins for building and publishing the docker image on DockerHub.
```
pipeline {
    environment {
        registry = "hackcoderr/flask:latest"
        registryCredential = 'dockercred'
        dockerImage = ''
        }
    agent any

    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}

```

# Kubernetes Server

All resources in Kubernetes are created using yaml configurations. We usually define pod inside deployment so need three yaml files.

Now as per these yaml files, lets create resources in kubernetes.

Start a Deployment that runs a container using the image made by CD/CD, and expose it as a Service using the following manifest.To do so, run the following command:
```
kubectl apply -f deployment.yaml
kubectl apply -f svc.yaml
```

### Create the HorizontalPodAutoscaler

Before creating HPA, create metrics pod and Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines.
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability.yaml
```
Create the HorizontalPodAutoscaler:

```
kubectl apply -f hpa.yaml
```

# ELK Stack

Apply ELK stack on Kubernetes cluster
```
kubectl apply -f elk/elasticsearch-ss.yaml 
kubectl apply -f elk/logstash-deployment.yaml 
kubectl apply -f elk/filebeat-ds.yaml 
kubectl apply -f elk/metricbeat-ds.yaml 
kubectl apply -f elk/kibana-deployment.yaml
```


## Test
Increase the load 

```
# Run this in a separate terminal
# so that the load generation continues and you can carry on with the rest of the steps
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://aeba27e5d759948ac83907902a079c08-1882761904.ap-south-1.elb.amazonaws.com:5000/; done"
```
Now run:
```
kubectl get hpa simple-flask-app --watch
```

