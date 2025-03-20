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
                withSonarQubeEnv(credentialsId: 'jenkins-sonar-token')
                 {   
                    sh 'mvn sonar:sonar'
                }
            }
        }
    }

}