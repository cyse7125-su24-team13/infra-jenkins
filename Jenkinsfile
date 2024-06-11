pipeline {
    agent any
    triggers {
        githubPullRequest {
            orgWhitelist('your-org')
            allowMembersOfWhitelistedOrgsAsAdmin()
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                // Add build steps here
            }
        }
        stage('Test') {
            steps {
                // Add test steps here
            }
        }
        stage('Deploy') {
            steps {
                // Add deployment steps here
            }
        }
    }
    post {
        success {
            githubNotify context: 'Jenkins', description: 'Build successful', status: 'SUCCESS'
        }
        failure {
            githubNotify context: 'Jenkins', description: 'Build failed', status: 'FAILURE'
        }
    }
}
