pipeline {
    agent {
        kubernetes {
            yamlFile 'agent.yaml'
        }
    }

    stages {
        stage('install') {
            steps {
                container('node') {
                    sh 'corepack enable'
                    sh 'pnpm install'
                }
            }
        }

        stage('test') {
            steps {
                container('node') {
                    sh 'pnpm test'
                }
            }
        }

        stage('build') {
            steps {
                container('node') {
                    sh 'pnpm build'
                }
            }
        }

        stage('push') {
            steps {
                container('docker') {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh '''
                            until docker info >/dev/null 2>&1; do sleep 2; done
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker build -t cristiandz/lab3-cristian:cristian-dz .
                            docker push cristiandz/lab3-cristian:cristian-dz
                        '''
                    }
                }
            }
        }

        stage('deploy') {
            steps {
                container('kubectl') {
                    sh 'kubectl apply -f entrega.yaml'
                }
            }
        }
    }
}
