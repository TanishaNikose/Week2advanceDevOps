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
                sh 'test -f index.html'
                echo 'Test Passed'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        sh 'docker push $IMAGE_NAME'
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: ['ec2-ssh']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@18.232.101.109 << EOF

                    sudo docker pull $IMAGE_NAME

                    sudo docker stop mywebsite || true

                    sudo docker rm mywebsite || true

                    sudo docker run -d \
                        --name mywebsite \
                        -p 80:80 \
                        $IMAGE_NAME

                    EOF
                    '''
                }
            }
        }

    }
}