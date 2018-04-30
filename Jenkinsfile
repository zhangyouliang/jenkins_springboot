node("master") {
    agent { docker 'java:8' }
    stages {
        def MVN_BIN = "${MVN_HOME}/bin/mvn"
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
                    ${MVN_BIN} package -Dmaven.test.skip=true
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
            }
        }
    }
}
