pipeline {
    agent any
    triggers {
        // Poll for changes every minute
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
        stage('Install Dependencies') {
            steps {
                script {
                    // Install unzip
                    sh 'sudo apt-get update && sudo apt-get install -y unzip'
                }
            }
        }
        stage('Set up Terraform') {
            steps {
                script {
                    // Install Terraform
                    sh """
                    wget https://releases.hashicorp.com/terraform/${env.TERRAFORM_VERSION}/terraform_${env.TERRAFORM_VERSION}_linux_amd64.zip
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
