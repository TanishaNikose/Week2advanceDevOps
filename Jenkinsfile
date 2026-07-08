pipeline {
    agent any

    environment {
        IMAGE_NAME = "tanishan/week2devops:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Application') {
            steps {
                echo 'Building Application...'
            }
        }

        stage('Run Test') {
            steps {
                bat '''
                if exist index.html (
                    echo Test Passed
                ) else (
                    exit /b 1
                )
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME% .'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        bat 'docker push %IMAGE_NAME%'
                    }
                }
            }
        }
    }
}