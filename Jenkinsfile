pipeline {
    agent any
    triggers {
        githubPullRequest {
            cron('* * * * *')
            orgWhitelist('your-org')
            allowMembersOfWhitelistedOrgsAsAdmin()
            useGitHubHooks()
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
                echo 'Building...'
                // Add your build commands here
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Add your test commands here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment commands here
            }
        }
    }
    post {
        success {
            script {
                def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                githubNotify context: 'Jenkins', description: 'Build successful', status: 'SUCCESS', sha: commitSha
            }
        }
        failure {
            script {
                def commitSha = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                githubNotify context: 'Jenkins', description: 'Build failed', status: 'FAILURE', sha: commitSha
            }
        }
    }
}
