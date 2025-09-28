pipeline {
    agent { label 'docker-build' } 
    environment {
        IMAGE_NAME = "mikiangelica/sampapp"
        IMAGE_TAG  = "v1"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    credentialsId: 'github-pat',
                    url: 'https://github.com/mikiangelica/k8s-manifests.git'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
						usernameVariable: 'DOCKER_USER',
						passwordVariable: 'DOCKER_PASS')]) {
                    sh """
		      docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfiles/sampapp/Dockerfile .
                      echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                      docker push $IMAGE_NAME:$IMAGE_TAG
                    """
		}
            }
        }
        stage('Update Manifests') {
            steps {
	    	withCredentials([usernamePassword(credentialsId: 'github-pat',
						usernameVariable: 'GIT_USER',
						passwordVariable: 'GIT_PASS')]) {
                sh """
                  sed -i 's|image: .*|	      image: $IMAGE_NAME:$IMAGE_TAG|' manifests/base/deployment.yaml
                  git config user.email "mikiangelica@gmail.com"
		  git config user.name "admin"
                  git add manifests/base/deployment.yaml
                  git commit -m "Update image to $IMAGE_NAME:$IMAGE_TAG" || echo "No changes to commit"
                  git push https://$GIT_USER:$GIT_PASS@github.com/mikiangelica/k8s-manifests.git master
                """
	    }
        }

        stage('Trigger ArgoCD Sync') {
            steps {
                withCredentials([string(credentialsId: 'argocd-token', variable: 'ARGOCD_TOKEN')]) {
                    sh """
                      curl -k -H "Authorization: Bearer $ARGOCD_TOKEN" \
                        -X POST https://192.168.81.128:31805/api/v1/applications/sampapp/sync
                    """
                }
            }
        }
    }
}
