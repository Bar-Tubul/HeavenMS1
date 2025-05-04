pipeline {
    agent any

    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.8.0_211'
        PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"
    }

    stages {
        stage('Clean Old Classes') {
            steps {
                bat 'rd /s /q out\\production\\HeavenMS || exit 0'
            }
        }

        stage('Compile') {
            steps {
                bat '''
                cd C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1
                dir /s /b src\\*.java > sources.txt
                javac -d out\\production\\HeavenMS @sources.txt
                '''
            }
        }

        stage('Restart Server') {
            steps {
                // Optional: kill previous server if running
                bat '''
                for /f "tokens=2 delims=," %%a in ('tasklist /FI "IMAGENAME eq java.exe" /FO CSV ^| findstr "net.server.Server"') do taskkill /PID %%a /F
                timeout /t 2
                '''

                bat '''
                cd C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1
                start "" java -Xmx2048m -cp out\\production\\HeavenMS -Dwzpath=wz\\ net.server.Server
                '''
            }
        }
    }
}
