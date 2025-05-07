pipeline {
    agent any

    environment {
        // Adjust JAVA_HOME if IntelliJ’s embedded JDK isn't available outside the IDE
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.8.0_452'
        PATH = "${env.JAVA_HOME}\\bin;${env.PATH}"
        WORK_DIR = 'C:\\Users\\Administrator\\IdeaProjects\\HeavenMS1'
        BUILD_DIR = "${WORK_DIR}\\out"
        SRC_DIR = "${WORK_DIR}\\src"
    }

    stages {
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

        stage('Run Server') {
            steps {
                dir("${WORK_DIR}") {
                    // Non-blocking start, runs server in background like IntelliJ
                    bat 'start /b java -cp HeavenMS net.server.Server'
                }
            }
        }
    }
}
