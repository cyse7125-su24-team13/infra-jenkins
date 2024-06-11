pipeline {
    agent any
    triggers {
        cron('* * * * *')
    }
    environment {
        TERRAFORM_VERSION = '1.7.3'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Set up Terraform') {
            steps {
                script {
                    // Install Terraform
                    sh """
                    wget https://releases.hashicorp.com/terraform/${env.TERRAFORM_VERSION}/terraform_${env.TERRAFORM_VERSION}_linux_amd64.zip
                    unzip terraform_${env.TERRAFORM_VERSION}_linux_amd64
                    unzip terraform_${env.TERRAFORM_VERSION}_linux_amd64.zip
                    sudo mv terraform /usr/local/bin/
                    terraform -version
                    """
                }
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
                githubNotify context: 'Terraform Validation', description: 'Validation successful', status: 'SUCCESS', sha: commitSha
            }
        }
        failure {
            script {
                def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                githubNotify context: 'Terraform Validation', description: 'Validation failed', status: 'FAILURE', sha: commitSha
            }
        }
    }
}
