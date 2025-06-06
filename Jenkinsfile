pipeline {
    agent { label 'observability' }
 tools {
         jdk 'openjdk-17'
     }

    environment {
        GIT_HASH = GIT_COMMIT.take(7)
    }

    stages {
 //       stage('Create volumes'){
 //          steps{
 //            sh 'docker volume create prometheus-data'
 //            sh 'docker volume create grafana-data'
 //            sh 'docker volume create alertmanager-data'
 //         }
 //        }
        stage('Deploy stack'){
           steps{
               sh 'docker compose up -d'
          }
    }
 }
}
