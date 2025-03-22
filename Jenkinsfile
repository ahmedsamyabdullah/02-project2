// Start Jenkin Pipeline
pipeline 
{
    // Specify Agent 
    agent any

    // Install some tools
    tools
    {
        jdk "java17"
        maven "Maven3"
    }

    // Set Environment variables
    environment
    {
        APP_NAME    = "02-project2"
        RELEASE     = "1.0.0"
        DOCKER_USER = "itahmedsamy"
        DOCKER_PASS = "pass-token"    // This is secret pass of dockerhub
        IMAGE_NAME  = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG   = "${RELEASE}-${BUILD_NUMBER}"
    }

    // Start pipeline Stages
    stages
    {

        // Delete all dirs & files before & after build process
        stage("Cleanup Workspace")
        {
            steps
            {
                cleanWs()
            }
        }

        // Get Repo from Github
        stage("Checkout From SCM")
        {
            steps
            {
                git branch: 'main', credentialsId: 'web-app-jenkins', url: 'https://github.com/ahmedsamyabdullah/02-project2.git'
            }
            
        }

        // Build App By Maven
        stage("Build App")
        {
            steps
            {
                sh 'mvn clean package'
            }
        }

        // Test App By Maven
        stage("Test App-maven")
        {
            steps
            {
                sh 'mvn test'
            }
        }

        //SonarQube COde Analysis
        stage("Sonarqube analysis")
        {
            steps
            {
               withSonarQubeEnv('SonarQube')
                {
                  withCredentials([string(credentialsId: 'jenkins-sonar-token', variable: 'SONAR_TOKEN')]) 
                  {
                     sh 'mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN'
                  }
                }
           }
        }

        // Build Docker Image
        stage("Docker Build")
        {
            steps
            {
                script
                {
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }
                
            }
        }

        // Push Docker-Image to DockerHub
        stage("Docker Push")
        {
            steps
            {
                script
                {
                    withCredentials([usernamePassword(credentialsId: 'pass-token', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')])
                    {
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                        sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                    }
                }
            }
        }
    }

}