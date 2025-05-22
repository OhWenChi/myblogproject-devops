pipeline {
    agent any

    environment {
        // Define environment variables for reuse throughout the pipeline
        VENV_DIR = "venv"  // Virtual environment directory
        PYTHON_HOME = "C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313"  // Path to Python interpreter
        IMAGE_NAME = "myblogapp:latest"  // Docker image name for the application
        STAGING_CONTAINER_NAME = "myblogapp-staging"  // Name of the staging Docker container
        PROD_CONTAINER_NAME = "myblogapp-prod" //  // Name of the production Docker container
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository and reset to the latest code on main
                git credentialsId: 'github-cred', url: 'https://github.com/OhWenChi/myblogproject-devops.git', branch: 'main'
                bat 'git fetch --all'  // Fetch all branches
                bat 'git reset --hard origin/main'  // Hard reset to the latest main branch
                bat 'git pull origin main'  // Pull latest changes
            }
        }

        stage('Build') {
            steps {
                echo '=== Build Stage ==='

                // Create Python virtual environment
                bat '"%PYTHON_HOME%\\python.exe" -m venv %VENV_DIR%'

                // Verify virtual environment directory
                bat 'dir %VENV_DIR%'

                // Activate the virtual environment and install dependencies
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install -r requirements.txt'

                // Confirm Python and pip versions installed
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && python --version'
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip list'
            }
        }

        stage('Test') {
            steps {
                echo '=== Test Stage with Coverage ==='

                // Install coverage tool to measure test coverage
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install coverage'

                // Run all unit tests and collect coverage data
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && coverage run -m unittest discover -s tests -p "*.py"'

                // Display coverage summary in console
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && coverage report'

                // Generate HTML coverage report
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && coverage html'
            }
        }

        stage('Code Quality') {
            steps {
                echo '=== Code Quality Stage ==='

                // Install code formatting and linting tools
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install black flake8'

                // Format code using Black (autoformatter)
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && black main.py forms.py tests'

                // Run flake8 to check for style and complexity issues
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && flake8 main.py forms.py tests || exit 0'
            }
        }

        stage('Security') {
            steps {
                echo '=== Security Stage ==='

                // Install the Safety tool to scan dependencies for known vulnerabilities
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && pip install safety'

                // Run full security check
                bat 'call %VENV_DIR%\\Scripts\\activate.bat && safety check --full-report || exit 0'
            }
        }

        stage('Deploy') {
            steps {
                echo '=== Deploy Stage (Docker Staging) ==='

                // Build Docker image for the application
                bat 'docker build -t %IMAGE_NAME% .'

                // Remove existing staging container if it exists
                bat 'docker rm -f %STAGING_CONTAINER_NAME% || exit 0'

                // Run the new Docker container for staging
                bat 'docker run -d --name %STAGING_CONTAINER_NAME% -p 8000:8000 %IMAGE_NAME%'
            }
        }

        stage('Verify Staging') {
            steps {
                echo '=== Verify Staging Application ==='
                // Wait a bit to allow container to start (optional but recommended)
                bat 'timeout /t 5 /nobreak >nul'

                // Check if app responds with HTTP 200 on localhost:8000
                bat '''
                powershell -Command "
                try {
                    $response = Invoke-WebRequest -Uri http://localhost:8000/ -UseBasicParsing -TimeoutSec 10
                    if ($response.StatusCode -eq 200) {
                        Write-Host 'Staging app is up and running.'
                    } else {
                        Write-Error 'Staging app returned non-200 status code.'
                        exit 1
                    }
                } catch {
                    Write-Error 'Failed to reach staging app.'
                    exit 1
                }"
                '''
            }
        }

        stage('Release') {
            steps {
                echo '=== Release Stage (Promote to Production) ==='

                // Remove existing production container if it exists
                bat 'docker rm -f %PROD_CONTAINER_NAME% || exit 0'

                // Run the production container (mapping to port 80)
                bat 'docker run -d --name %PROD_CONTAINER_NAME% -p 80:8000 %IMAGE_NAME%'
            }
        }

        stage('Verify Production') {
            steps {
                echo '=== Verify Production Application ==='
                // Wait a bit for container to start
                bat 'timeout /t 5 /nobreak >nul'

                // Check if app responds with HTTP 200 on localhost:80
                bat '''
                powershell -Command "
                try {
                    $response = Invoke-WebRequest -Uri http://localhost/ -UseBasicParsing -TimeoutSec 10
                    if ($response.StatusCode -eq 200) {
                        Write-Host 'Production app is up and running.'
                    } else {
                        Write-Error 'Production app returned non-200 status code.'
                        exit 1
                    }
                } catch {
                    Write-Error 'Failed to reach production app.'
                    exit 1
                }"
                '''
            }
        }

        stage('Monitoring') {
            steps {
                echo '=== Monitoring Stage ==='

                // Simulate monitoring setup
                echo 'Simulating Datadog integration...'
                echo 'If deployed to a cloud host, we would install the Datadog Agent:'
                echo 'Command: docker run -d --name dd-agent -e DD_API_KEY=<your_api_key> datadog/agent:latest'
                echo 'Metrics Monitored: CPU, Memory, Response Time, Error Rate'
                echo 'Alerts: Email/SMS alerts would be triggered on anomalies'
            }
        }
    }

    post {
        success {
            // Notify on successful pipeline run
            echo 'Pipeline executed successfully.'
        }
        failure {
            // Notify on failure and advise to check logs
            echo 'Pipeline failed. Check logs for troubleshooting.'
        }
    }
}
