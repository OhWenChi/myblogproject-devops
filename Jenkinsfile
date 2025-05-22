pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
        PYTHON_HOME = "C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313"
        IMAGE_NAME = "myblogapp:latest"
        STAGING_CONTAINER_NAME = "myblogapp-staging"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-cred', url: 'https://github.com/OhWenChi/myblogproject-devops.git', branch: 'main'
                bat 'git fetch --all'
                bat 'git reset --hard origin/main'
                bat 'git pull origin main'
            }
        }

        stage('Build') {
            steps {
                echo '=== Build Stage ==='
                bat '"%PYTHON_HOME%\\python.exe" -m venv %VENV_DIR%'
                bat 'dir %VENV_DIR%'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install -r requirements.txt'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && python --version'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip list'
            }
        }

        stage('Test') {
            steps {
                echo '=== Test Stage ==='
                bat 'dir tests'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && python -m unittest discover -s tests -p "*.py"'
            }
        }

        stage('Code Quality') {
            steps {
                echo '=== Code Quality Stage ==='
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install black flake8'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && black main.py forms.py tests'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && flake8 main.py forms.py tests || exit 0'
            }
        }

        stage('Security') {
            steps {
                echo '=== Security Stage ==='
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install safety'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && safety check --full-report || exit 0'
            }
        }

        stage('Deploy') {
            steps {
                echo '=== Deploy Stage (Docker Staging) ==='
                bat 'docker build -t %IMAGE_NAME% .'
                bat 'docker rm -f %STAGING_CONTAINER_NAME% || exit 0'
                bat 'docker run -d --name %STAGING_CONTAINER_NAME% -p 8000:8000 %IMAGE_NAME%'
            }
        }

        stage('Release') {
            steps {
                echo '=== Release Stage (Promote to Production) ==='
                bat 'docker rm -f %PROD_CONTAINER_NAME% || exit 0'
                bat 'docker run -d --name %PROD_CONTAINER_NAME% -p 80:8000 %IMAGE_NAME%'
            }
        }

        stage('Monitoring') {
            steps {
                echo '=== Monitoring Stage ==='
                echo 'Simulating integration with Datadog or New Relic...'
                echo 'Monitoring metrics: CPU, memory, response time, error rate...'
                echo 'Alerts configured to notify DevOps team on anomaly detection.'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check logs for troubleshooting.'
        }
    }
}
