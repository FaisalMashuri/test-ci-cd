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

        stage('Push to GitHub Container Registry') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'ghcr-token', usernameVariable: 'GHCR_USER', passwordVariable: 'GHCR_PAT')]) {
                   sh '''
                       echo $GHCR_PAT | docker login ghcr.io -u $GHCR_USER --password-stdin
                       docker push $IMAGE_NAME
                   '''
               }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        export KUBECONFIG=$KUBECONFIG_FILE
                        kubectl apply -f deploy/deployment.yaml
                    '''
                }
            }
        }
    }
}
