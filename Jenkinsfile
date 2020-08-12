pipeline {
    environment {
        /* Specify the Docker hub account and repository name */
        registry = "chahardoli/fibo-frontend"

        /* Provide the docker credential name in the Jenkins server */
        registryCredential = 'docker-hub-credentials'

        /* Define the variable of docker image */
        dockerImage = ''
    }
    agent {
        /* Specify the slave node via docker engine */
        label 'slave'
    }
    stages {

        stage('Clone repository') {
            /* Make sure the repository cloned to the workspace */
            steps{
                git 'https://github.com/johann-sebastian-bach/sample-fibonacci'
            }
        }

        stage('Build Frontend') {
            steps{
                script{
                    /* Build the Frontend docker image */
                    dockerImage = docker.build registry, "-f ./frontend/Dockerfile ./frontend"
                }
            }
        }

        stage('Push Frontend Image'){
            steps{
                script{
                    /* Push the Frontend docker image via Git SHA and latest tags */
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("latest")
                        dockerImage.push("${env.GIT_COMMIT}")
                    }
                }
            }
        }

        stage('Remove Unused Frontend docker image') {
            steps{
                /* Clean the Frontend docker image from slave */
                sh "docker images | grep fibo-frontend | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi chahardoli/fibo-frontend:{}"
            }
        }

        stage('Build Backend') {
            steps{
                script{
                    /* Build the Backend docker image */
                    dockerImage = docker.build registry, "-f ./backend/Dockerfile ./backend"
                }
            }
        }

        stage('Push Backend Image'){
            steps{
                script{
                    /* Push the Backend docker image via Git SHA and latest tags */
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push("latest")
                        dockerImage.push("${env.GIT_COMMIT}")
                    }
                }
            }
        }

        stage('Remove Unused Backend docker image') {
            steps{
                /* Clean the Backend docker image from slave */
                sh "docker images | grep fibo-backend | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi chahardoli/fibo-backend:{}"
            }
        }
    }
}