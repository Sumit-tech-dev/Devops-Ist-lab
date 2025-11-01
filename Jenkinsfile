pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'sumitsachdeva245'          // your Docker Hub username
        DOCKER_HUB_APP  = 'devops-lab'                // your Docker Hub repo name
    }

    stages {

        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Sumit-tech-dev/Devops-Ist-lab.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_HUB_USER}/${DOCKER_HUB_APP}:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Use Jenkins credentials for Docker Hub login
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        sh 'docker push ${DOCKER_HUB_USER}/${DOCKER_HUB_APP}:latest'
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if running, then redeploy
                    sh '''
                        docker ps -q --filter "name=devops-lab" | grep -q . && docker stop devops-lab && docker rm devops-lab || true
                        docker run -d --name devops-lab -p 3000:3000 ${DOCKER_HUB_USER}/${DOCKER_HUB_APP}:latest
                    '''
                }
            }
        }

        stage('Cleanup Unused Images') {
            steps {
                sh 'docker system prune -f'
            }
        }
    }
}

