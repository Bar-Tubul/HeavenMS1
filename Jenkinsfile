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
                bat '''
                if exist "C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1\\out" (
                    rmdir /s /q "C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1\\out"
                )
                '''
            }
        }

        stage('Compile') {
            steps {
                bat '''
                cd "C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1"
                call gradlew.bat build
                '''
                // Replace with actual compile command if not using Gradle
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
