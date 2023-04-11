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
      CONSUL_HTTP_ADDR = "http://tasks.consul-agent:8500"
      ST_PROJECT       = "Daevon_Challenge"
      SSH_CREDENTIAL   = "jenkins-git-ssh-key"
      DRP_DC_TO_UPDATE = "/tmp/DRP_DC_TO_UPDATE.txt"
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
        stage('Checkout') {
            steps {
                git url: 'https://github.com/melovagabond/Daevon_Challenge.git', branch: 'develop'
            }
        }

        stage('Terraform init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        always {
            dir('terraform') {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
