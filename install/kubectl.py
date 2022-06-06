import os,subprocess

os.system("curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl")
os.system("chmod +x ./kubectl")
os.system("sudo mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin")
os.system("echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc")
