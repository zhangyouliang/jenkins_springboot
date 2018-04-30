pipeline {
    //agent { docker 'java:8' }
    agent none
    stages {
        stage('test'){
            agent any
            steps{
                echo 'Testing..'
                sh """
                    mvn clean && mvn test
                """
            }
        }
        stage('build') {
            agent any
            steps {
                echo 'Buding..'
                sh """
                    mvn package -Dmaven.test.skip=true
                """
            }
        }

        stage('Deploy') {
            agent any
            when {
                expression {
                    /*如果测试失败，状态为UNSTABLE*/
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo 'Deploying..'
            }
        }
    }

}

