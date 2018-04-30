pipeline {
    //agent { docker 'java:8' }
    agent any
    stages {
        stage('test'){
            steps{
                echo 'Testing..'
                sh """
                    mvn clean && mvn test
                """
            }
        }
        stage('build') {
            steps {
                echo 'Buding..'
                sh """
                    mvn package -Dmaven.test.skip=true
                """
            }
        }

        stage('Deploy') {
            when {
                expression {
                    /*如果测试失败，状态为UNSTABLE*/
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo 'Deploying..'
                sh """
                    chmod a+x docker.sh && docker.sh
                """
            }
        }
    }

}

