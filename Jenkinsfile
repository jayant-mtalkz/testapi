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
       stage('Deploy') {
            steps {
                sh 'cd'
                sh 'kubectl get pod -o wide --kubeconfig /var/lib/jenkins/.kube/config'
            }
        }
    }
}
