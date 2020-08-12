pipeline {
    environment {
        registry = "chahardoli/fibo-frontend"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }
    agent {
        label 'slave'
    }
    stages {

        stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

            steps{
                git 'https://github.com/johann-sebastian-bach/sample-fibonacci'
            }
        }

        stage('Build Frontend') {
            steps{
                script{
                    dockerImage = docker.build registry, "-f ./frontend/Dockerfile ./frontend"
                }
            }
        }

        stage('Push Frontend Image'){
            steps{
                script{
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("latest")
                        dockerImage.push("${env.GIT_COMMIT}")
                    }
                }
            }
        }

        stage('Remove Unused docker image') {
            steps{
                //sh "docker rmi $registry:latest"
                sh "docker images | grep fibo-frontend | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi chahardoli/fibo-frontend:{}"
            }
        }
    }
}