pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
    }
    post {
        success {
            script {
                def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                echo "Validation successful for commit ${commitSha}"
                githubNotify context: 'CI', status: 'SUCCESS', description: 'Build passed', targetUrl: "${env.BUILD_URL}"
            }
        }
        failure {
            script {
                def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                echo "Validation failed for commit ${commitSha}"
                githubNotify context: 'CI', status: 'FAILURE', description: 'Build failed', targetUrl: "${env.BUILD_URL}"
            }
        }
    }
}
