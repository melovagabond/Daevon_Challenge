pipeline {
    agent {
        label "local"
    }

    parameters {
        choice(name: 'TERRAFORM_COMMAND', choices: ['plan', 'apply', 'destroy'], description: 'Select Terraform command to run')
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning the remote Git repository..."
                git branch: 'jenkins', url: 'https://github.com/melovagabond/Daevon_Challenge.git'
            }
        }
        stage('SonarQube Analysis') {
            environment {
                PATH = "${PATH}:/opt/sonar-scanner/bin"
            }
            steps {
                echo "Running SonarQube analysis..."
                sh 'sonar-scanner \
                    -Dsonar.projectKey=SE-4495 \
                    -Dsonar.projectName="SED" \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://10.0.0.250:9000 \
                    -Dsonar.login=\$SONAR_SED'
            }
        }
        stage('Terraform') {
            steps {
                script {
                    if (params.TERRAFORM_COMMAND == 'plan') {
                        echo "Running terraform init and plan commands..."
                        sh 'cd website/AWS/ec2 && terraform init && terraform plan'
                    } else if (params.TERRAFORM_COMMAND == 'apply') {
                        echo "Running terraform apply commands..."
                        sh 'cd website/AWS/ec2 && terraform init && terraform apply -auto-approve'
                    } else if (params.TERRAFORM_COMMAND == 'destroy') {
                        echo "Running terraform destroy commands..."
                        sh 'cd website/AWS/ec2 && terraform init && terraform destroy -auto-approve'
                    } else {
                        echo "Invalid option selected!"
                        error('Invalid option selected!')
                    }
                }
            }
        }
        stage('Clean Workspace') {
            when {
                expression {params.TERRAFORM_COMMAND == 'destroy'}
            }
            steps {
                cleanWs()
            }
        }
    }
}
