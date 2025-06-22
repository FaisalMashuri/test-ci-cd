pipeline {
    agent any

    environment {
        IMAGE_NAME = "ghcr.io/faisalmashuri/test-ci-cd:latest"
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

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deploy/deployment.yaml'
            }
        }
    }
}
