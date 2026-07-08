pipeline {

    agent any


    environment {

        IMAGE_NAME = "tanishan/week2devops:latest"

        EC2_IP = "18.232.101.109"

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
                    echo Test Failed
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

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {


                    bat '''

                    docker login -u %DOCKER_USER% -p %DOCKER_PASS%

                    docker push %IMAGE_NAME%

                    '''

                }

            }

        }



        stage('Deploy to EC2') {

            steps {

                script {


                    def remote = [

                        name: 'aws-ec2',

                        host: "${EC2_IP}",

                        user: "ubuntu",

                        identityFile: "C:\\Users\\Webkorps\\.ssh\\myfirstkeypair.pem",

                        allowAnyHosts: true

                    ]


                    sshCommand remote: remote, command: """

                        docker pull ${IMAGE_NAME}

                        docker stop week2-container || true

                        docker rm week2-container || true


                        docker run -d \\
                        --name week2-container \\
                        -p 80:80 \\
                        ${IMAGE_NAME}

                    """

                }

            }

        }


    }



    post {


        success {

            echo 'Pipeline executed successfully!'

        }


        failure {

            echo 'Pipeline failed.'

        }


    }


}