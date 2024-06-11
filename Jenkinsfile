pipeline {
    agent any
    triggers {
        githubPush()
    }
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
                // Here you can add the appropriate notification step, e.g., GitHub Commit Status or other
            }
        }
        failure {
            script {
                def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                echo "Validation failed for commit ${commitSha}"
                // Here you can add the appropriate notification step, e.g., GitHub Commit Status or other
            }
        }
    }
}
