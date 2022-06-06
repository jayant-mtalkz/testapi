import os,subprocess

os.system("sudo yum install curl unzip -y")
os.system("curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip")
os.system("sudo unzip awscliv2.zip")
os.system("sudo ./aws/install")
os.system("sudo rm -rf awscliv2.zip")

operating_system = subprocess.getoutput('hostnamectl').split('\n')[6].split(':')[1]
#print(operating_system)

if 'Redhat' in operating_system or ':Amazon' in operating_system or 'Centos' in operating_system:
        os.system("sudo yum install -y yum-utils")
        os.system("sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo")
        os.system("sudo yum -y install terraform")
elif 'Ubuntu' in operating_system:
        os.system("sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl")
        os.system("curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -")
        os.system("sudo apt-add-repository deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main")
        os.system("sudo apt-get update && sudo apt-get install terraform")
