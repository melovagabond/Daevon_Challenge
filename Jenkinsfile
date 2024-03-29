pipeline {
    agent any

  options {
        timestamps()
        ansiColor('xterm')
        // 90 minute timeout
        timeout(time: 90, unit: 'MINUTES')
        disableConcurrentBuilds(abortPrevious: true)
  }
  environment {
      MASTER_BRANCH    = "develop"
      GIT_SSH_URL      = "git@github.com:melovagabond/Daevon_Challenge.git"
      ST_PROJECT       = "Daevon_Challenge"
      SSH_CREDENTIAL   = "jenkins-git-ssh-key"
      ANSIBLE_COLOR_DEBUG           = "bright purple"
  }

    stages {

         stage('Pull Secrets') {
            steps {
                script {
                    def secrets = [
                        [path: 'path/to/secret', engineVersion: 2, secretValues: [
                            [envVar: 'MY_SECRET_KEY', vaultKey: 'mySecretKey'],
                            [envVar: 'MY_SECRET_VALUE', vaultKey: 'mySecretValue']
                        ]]
                    ]

                    withVault(secrets) {
                        sh '''
                            echo "Secret Key: ${MY_SECRET_KEY}"
                            echo "Secret Value: ${MY_SECRET_VALUE}"
                        '''
                    }
                }
            }
        }
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/develop']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/melovagabond/Daevon_Challenge.git']])
            }
        }
        stage ("init"){
            steps{
                sh("terraform init -reconfigure")
            }
        }

        stage ("plan"){
            steps{
                sh("terraform plan")
            }
        }

        stage ("action"){
            steps {
                echo "Terraform action is --> ${action}"
                sh("terraform ${action} --auto-approve")
            }
        }
    }

    // post {
    //     always {
    //         dir('terraform') {
    //             sh 'terraform destroy -auto-approve'
    //         }
    //     }
    // }
}