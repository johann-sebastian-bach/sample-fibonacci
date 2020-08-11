node {
    def backend
    def frontend
    def worker
    def nginx

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build Frontend') {
        /* This builds the test image; synonymous to docker build on the command line */

        frontend = docker.build("chahardoli/fibo-frontend", "-f ./frontend/Dockerfile.dev ./frontend")
    }

    stage('Test Frontend') {
        /* Ideally, we would run a test framework against our image. */

        frontend.inside {
            sh 'npm test'
        }
    }

    stage('Build Frontend') {
        /* This builds the actual image; synonymous to docker build on the command line */

        frontend = docker.build("chahardoli/fibo-frontend", "-f ./frontend/Dockerfile ./frontend")
    }

    stage('Build Backend') {
        /* This builds the actual image; synonymous to docker build on the command line */

        backend = docker.build("chahardoli/fibo-backend", "-f ./backend/Dockerfile ./backend")
    }

    stage('Build Worker') {
        /* This builds the actual image; synonymous to docker build on the command line */

        worker = docker.build("chahardoli/fibo-worker", "-f ./worker/Dockerfile ./worker")
    }

    stage('Build Nginx') {
        /* This builds the actual image; synonymous to docker build on the command line */

        nginx = docker.build("chahardoli/fibo-nginx", "-f ./nginx/Dockerfile ./nginx")
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the Simple Hashing Algorithm from Git
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.GIT_COMMIT}")
            app.push("latest")
        }
    }
}
