pipeline {
    agent any

    environment {
        USERNAME = "faisalmashuri"
        IMAGE_NAME = "ghcr.io/${USERNAME}/test-ci-cd:latest"
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'master', credentialsId: 'github-token', url: 'https://github.com/FaisalMashuri/test-ci-cd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to GitHub Container Registry') {
            steps {
                withCredentials([string(credentialsId: 'ghcr-token', variable: 'TOKEN')]) {
                    sh '''
                      echo $TOKEN | docker login ghcr.io -u $USERNAME --password-stdin
                      docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deploy/deployment.yaml'
            }
        }
    }
}
