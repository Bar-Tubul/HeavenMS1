pipeline {
    agent any

    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.8.0_452'
        PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"
        WORK_DIR = 'C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1'
        BUILD_DIR = "${WORK_DIR}\\out"
        MAIN_CLASS = "net.server.Server"
    }

    stages {
        stage('Stop Existing Server') {
            steps {
                script {
                    bat """
                    for /f "tokens=2" %%i in ('tasklist /fi "imagename eq java.exe" /v ^| findstr /i "%MAIN_CLASS%"') do (
                        echo Killing process ID %%i running %MAIN_CLASS%
                        taskkill /PID %%i /F
                    )
                    """
                }
            }
        }

        stage('Clean Previous Build') {
            steps {
                dir("${BUILD_DIR}") {
                    deleteDir()
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
                    bat 'start /b java -cp HeavenMS net.server.Server'
                }
            }
        }
    }
}
