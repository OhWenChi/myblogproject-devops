pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
    }

    stages {
        stage('Build') {
            steps {
                echo '=== Build Stage ==='
                sh 'python -m venv $VENV_DIR'
                sh '. $VENV_DIR/bin/activate && pip install -r requirements.txt'
            }
        }

        stage('Test') {
            steps {
                echo '=== Test Stage ==='
                sh '. $VENV_DIR/bin/activate && python -m unittest discover tests'
            }
        }

        stage('Code Quality') {
            steps {
                echo '=== Code Quality Stage ==='
                sh '. $VENV_DIR/bin/activate && pip install flake8 && flake8 .'
            }
        }

        stage('Security') {
            steps {
                echo '=== Security Scan ==='
                sh '. $VENV_DIR/bin/activate && pip install safety && safety check || true'
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
