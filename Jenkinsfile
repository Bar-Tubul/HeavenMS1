pipeline {
    agent any

    environment {
        PROJECT_DIR = 'C:/Users/Administrator/IdeaProjects/HeavenMS1'
        JAVA_PATH = 'C:/Users/Administrator/Downloads/openlogic-openjdk-8u452-b09-windows-x64/openlogic-openjdk-8u452-b09-windows-x64/bin/java.exe'
    }

    stages {
        stage('Stop Existing Server') {
            steps {
                powershell '''
                $javaProcesses = Get-WmiObject Win32_Process | Where-Object {
                    $_.CommandLine -like "*net.server.Server*" -and $_.ExecutablePath -eq "$env:JAVA_PATH"
                }
                foreach ($proc in $javaProcesses) {
                    Write-Host "Killing Java process ID $($proc.ProcessId)"
                    Stop-Process -Id $proc.ProcessId -Force
                }
                '''
            }
        }

        stage('Clean Previous Build') {
            steps {
                echo 'Skipping cleanup of out directory, building directly...'
                // If you want to clean the out directory, you can enable the line below
                // bat 'rmdir /s /q "C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1\\out"'
            }
        }

        stage('Compile') {
            steps {
                script {
                    // Example: If you have a custom batch file to compile the project
                    echo 'Building the project with custom command...'
                    bat '''
                    cd "C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1"
                    call build.bat  // Replace with your actual build command or script
                    '''
                }
            }
        }

        stage('Start Server') {
            steps {
                powershell '''
                Start-Process -NoNewWindow -FilePath "$env:JAVA_PATH" -ArgumentList @(
                    "-classpath",
                    "$env:PROJECT_DIR\\out\\production\\HeavenMS;other\\needed\\libs",
                    "net.server.Server"
                )
                '''
                // Add any necessary libraries to classpath
            }
        }
    }

    post {
        failure {
            echo 'Build failed.'
        }
        success {
            echo 'Build and server start succeeded.'
        }
    }
}
