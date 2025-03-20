// Start Jenkin Pipeline
pipeline 
{
    // Specify Agent 
    agent any
    tools
    {
        jdk "java17"
        maven "Maven3"
    }
    stages
    {
        stage("Cleanup Workspace")
        {
            steps
            {
                cleanWs()
            }
        }
        stage("Checkout From SCM")
        {
            steps
            {
                git branch: 'main', credentialsId: 'web-app-jenkins', url: 'https://github.com/ahmedsamyabdullah/02-project2.git'
            }
            
        }
    }

}