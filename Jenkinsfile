pipeline {
    agent any

    stages {
        stage('CI') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockeraccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                git 'https://github.com/marwaahmed11/Python-app'
                sh """
                cd ./python-app 
                docker login -u ${USERNAME} -p ${PASSWORD}
                docker build . -f dockerfile -t marwaahmed11/python-app-new:v1.0  --network host
                docker push marwaahmed11/python-app-new:v1.0
                """
                }
            }
        }
         stage('CD') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockeraccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                git 'https://github.com/marwaahmed11/Python-app' 
                sh """
                docker login -u ${USERNAME} -p ${PASSWORD}
                pwd
                
                kubectl apply -f /var/jenkins_home/workspace/python-app/Deployment/redis-deployment.yaml -n app
                kubectl apply -f /var/jenkins_home/workspace/python-app/Deployment/redis-service.yaml -n app
                kubectl apply -f /var/jenkins_home/workspace/python-app/Deployment/configMap.yaml -n app
                kubectl apply -f /var/jenkins_home/workspace/python-app/Deployment/deployment.yaml -n app
                kubectl apply -f /var/jenkins_home/workspace/python-app/Deployment/load-balancer-service.yaml -n app
            
                """
                }
            }
        }
    }
}