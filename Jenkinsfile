pipeline {
    agent any
    environment {
        IMAGE = 'YOUR_DOCKERHUB_USER/demo-web'
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Deploy Sample App') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl apply -f k8s/
                        kubectl rollout status deployment/demo-web --timeout=120s
                    '''
                }
            }
        }
        stage('Verify') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl get deployments,pods,svc -l app=demo-web -o wide
                    '''
                }
            }
        }
    }
    post {
        success { echo 'Pipeline finished successfully.' }
        failure { echo 'Pipeline failed - check the console output.' }
    }
}
