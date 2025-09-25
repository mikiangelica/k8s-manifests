pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/mikiangelica/k8s-manifests.git'
            }
        }
        stage('Lint Manifests') {
            steps {
                sh 'kubectl kustomize k8s-manifests/ > /dev/null || true'
            }
        }
        stage('Build & Push Image') {
            steps {
                sh '''
                docker build -t mikiangelica/sampapp:${BUILD_NUMBER} .
                docker push mikiangelica/sampapp:${BUILD_NUMBER}
                '''
            }
        }
        stage('Update Manifests') {
            steps {
                sh '''
                sed -i "s|image: .*$|image: mikiangelica/sampapp:${BUILD_NUMBER}|" sampapp/manifests/app/deployment.yaml
                git config --global user.email "mikiangelica@gmail.com"
                git config --global user.name "jenkins"
                git commit -am "Update image to build ${BUILD_NUMBER}"
                git push origin master
                '''
            }
        }
    }
}
