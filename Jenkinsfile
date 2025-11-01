pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'your-dockerhub-username'
        DOCKER_HUB_APP = 'your-dockerhub-repo-name'
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
            sh 'docker build -t sumitsachdeva245/devops-lab:latest .'
        }
    }
}

        
    stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'echo $DOCKER_HUB_PASS | docker login -u $DOCKER_HUB_USER --password-stdin'
                    sh 'docker push $DOCKER_HUB_USER/$DOCKER_HUB_APP:latest'
                }
            }
        }
       
        stage('Deploy Container') {
            steps {
                script {
                    sh 'docker run -d -p 3000:3000 $DOCKER_HUB_USER/$DOCKER_HUB_APP:latest'
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
