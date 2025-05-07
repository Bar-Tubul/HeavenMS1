pipeline {
    agent any

    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.8.0_452'
        PATH = "${JAVA_HOME}\\bin;${PATH}"
        WORK_DIR = 'C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1'
        BUILD_DIR = "${WORK_DIR}\\out"
        MAIN_CLASS = "net.server.Server"
        CLASSPATH = "out"  // We'll compile and run from this
    }

    stages {

        stage('Stop Existing Server') {
            steps {
                powershell '''
                $javaProcs = Get-CimInstance Win32_Process -Filter "Name = 'java.exe'" |
                    Where-Object { $_.CommandLine -match 'net\\.server\\.Server' }

                if ($javaProcs.Count -eq 0) {
                    Write-Host "No server process found running net.server.Server. Continuing..."
                } else {
                    foreach ($proc in $javaProcs) {
                        Write-Host "Killing Java process ID $($proc.ProcessId) running: $($proc.CommandLine)"
                        Stop-Process -Id $proc.ProcessId -Force
                    }
                }
                '''
            }
        }

        stage('Clean Previous Build') {
            steps {
                script {
                    def buildDir = "${BUILD_DIR.replaceAll('\\\\', '/')}"
                    bat "if exist ${buildDir} rmdir /s /q ${buildDir}"
                }
            }
        }

        stage('Compile') {
            steps {
                dir("${WORK_DIR}") {
                    bat "mkdir out"
                    bat "javac -d out -cp . src\\net\\server\\Server.java"
                }
            }
        }

        stage('Start Server') {
            steps {
                dir("${WORK_DIR}") {
                    bat "start \"HeavenMS Server\" /b java -cp ${CLASSPATH} ${MAIN_CLASS}"
                }
            }
        }
    }
}
