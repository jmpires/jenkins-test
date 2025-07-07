pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'jenkins-test:latest'
        REGISTRY = 'docker.io/jmpires'  // Your Docker Hub username
        // DEPLOY = 'jmpires@localhost'  // SSH user for deployment (optional)
    }


        stage('Debug Env Vars') {
            steps {
                sh 'echo DOCKER_IMAGE is: $DOCKER_IMAGE'
                sh 'echo REGISTRY is: $REGISTRY'
            }
        }

        stage('Build') {
            steps {
                sh "docker build --no-cache -t $DOCKER_IMAGE ."
            }
        }

        stage('Test') {
            steps {
                sh "docker run --rm $DOCKER_IMAGE pytest tests/"
            }
        }

        stage('Push Image') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub-cred', url: 'https://index.docker.io/v1/') {
                    sh "docker tag $DOCKER_IMAGE ${REGISTRY}/${DOCKER_IMAGE}"
                    sh "docker push ${REGISTRY}/${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['deploy-key']) {
                    sh """
                    ssh jmpires@localhost "docker pull ${REGISTRY}/${DOCKER_IMAGE} && \
                    docker stop myapp || true && \
                    docker rm myapp || true && \
                    docker run -d --name myapp -p 80:80 ${REGISTRY}/${DOCKER_IMAGE}"
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful'
        }
        failure {
            echo 'Deployment Failed'
        }
    }
}
