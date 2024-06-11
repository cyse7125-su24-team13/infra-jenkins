pipeline {
    agent any

    triggers {
        githubPullRequest()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Status Check') {
            steps {
                script {
                    // Example status check
                    echo 'Performing status check...'
                    // Add your status check logic here
                    // For example, running tests or linting
                    // sh 'make test'
                }
            }
        }
    }

    post {
        always {
            script {
                // Notify GitHub of the build result
                def commitStatus = currentBuild.result == 'SUCCESS' ? 'success' : 'failure'
                githubNotify context: 'PR Status Check', status: commitStatus, description: 'Jenkins build result'
            }
        }
    }
}
