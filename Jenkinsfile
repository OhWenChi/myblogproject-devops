pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
    }

    stages {
        stage('Build') {
            steps {
                echo '=== Build Stage ==='
                bat 'where python'
                bat 'python --version'
                bat '"C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m venv $VENV_DIR'
                bat 'call $VENV_DIR\\Scripts\\activate && pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                echo '=== Test Stage ==='
                bat '. $VENV_DIR/bin/activate && python -m unittest discover tests'
            }
        }

        stage('Code Quality') {
            steps {
                echo '=== Code Quality Stage ==='
                bat '. $VENV_DIR/bin/activate && pip install flake8 && flake8 .'
            }
        }

        stage('Security') {
            steps {
                echo '=== Security Scan ==='
                bat '. $VENV_DIR/bin/activate && pip install safety && safety check || true'
            }
        }

        stage('Deploy') {
            steps {
                echo '=== Deploy Stage ==='
                // This is a placeholder - update this with actual deployment logic
                echo 'Deploying to staging environment...'
            }
        }

        stage('Release') {
            steps {
                echo '=== Release Stage ==='
                // Simulate promoting to production
                echo 'Releasing to production...'
            }
        }

        stage('Monitoring') {
            steps {
                echo '=== Monitoring Stage ==='
                // Placeholder: integrate with Datadog, Prometheus, etc.
                echo 'Monitoring in progress...'
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
