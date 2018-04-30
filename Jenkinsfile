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
                    aliimage=10.0.0.44:5000/jenkins_springboot:`TZ=CST-8 date '+%Y%m%d-%H%M'`
                    if [ "`docker images | awk '/^10.0.0.44:5000/ { print $3 }'`" ]; then docker rmi -f $(docker images | awk '/^10.0.0.44:5000/ { print $3 }' ); fi
                    mvn clean install -U  -Dmaven.test.skip=true
                    docker build --no-cache -t $aliimage .
                    echo "Push Image:" $aliimage " to repository..."
                    docker push $aliimage
                """
            }
        }
    }

}

