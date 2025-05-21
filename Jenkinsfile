pipeline {
    agent any

    environment {
        VENV_DIR = "venv"
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

                // Print PATH environment variable for debugging
                bat 'echo %PATH%'

                // Ensure Python virtual environment is created
                bat '"C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m venv venv'

                // Confirm virtual environment folder exists
                bat 'dir venv'

                // Activate virtual environment and install dependencies
                bat 'call venv\\Scripts\\activate.bat && pip install -r requirements.txt'

                // Verify Python version inside virtual environment
                bat 'call venv\\Scripts\\activate.bat && python --version'

                // Confirm installed packages
                bat 'call venv\\Scripts\\activate.bat && pip list'
            }
        }

        stage('Test') {
            steps {
                echo '=== Test Stage ==='

                // Verify test directory exists
                bat 'dir tests'

                // Activate virtual environment and run tests
                bat 'call venv\\Scripts\\activate.bat && python -m unittest discover -s tests -p "*.py"'
            }
        }

        stage('Code Quality') {
            steps {
                echo '=== Code Quality Stage ==='

                // Ensure Python is recognized by Jenkins
                bat '"C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" --version'

                // Activate virtual environment
                bat 'call venv\\Scripts\\activate.bat'

                // Upgrade pip to avoid issues
                bat '"C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m ensurepip'
                bat '"C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pip install --upgrade pip'

                // Install required dependencies (flake8, black for formatting)
                bat '"C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\python.exe" -m pip install flake8 black'

                // Run `black` for automatic code formatting (optional but recommended)
                bat 'call venv\\Scripts\\activate.bat && black .'

                // Run `flake8` to check linting issues, excluding `venv` and third-party libraries
                bat 'call venv\\Scripts\\activate.bat && flake8 --exclude=venv,pip_vendor .'
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
