def BRANCH_NAME = 'main'
pipeline {
  parameters { // {
    choice(
      name: 'P_SLAVE1',
      description: '',
      choices: ['NULL', 'UC_251_NEWFILE_run'] as List
    )
    choice(
      name: 'P_SLAVE2',
      description: '',
      choices: ['NULL', 'UC_251_NEWFILE_run'] as List
    )
	
  } // }
  agent none
  options {
    skipDefaultCheckout()
    buildDiscarder(logRotator(
      numToKeepStr: '10' + (BRANCH_NAME == 'dev' ? '' : '0'),
      daysToKeepStr: '10' + (BRANCH_NAME == 'dev' ? '' : '0'),
    ))
  }
  stages {
    stage('Build On slave1') {
	when {
	    expression {
            return P_SLAVE1.toString()!='NULL';
        }        
    }
		agent {
            label 'slave1'
        }
		steps {
			script {
				scmInfo = checkout scm
				f = fileExists 'README.md'
				echo "f=${f}"
				sh 'chmod +x test.sh'
				sh 'chmod +x run.sh'
				sh 'chmod +x build.sh'
				sh 'chmod +x entrypoint.sh'
			}
		
		}
	
	}
	stage('Build On slave2') {
	when {
	    expression {
            return P_SLAVE2.toString()!='NULL';
        }        
    }
		agent {
            label 'slave2'
        }
		steps {
			script {
				scmInfo = checkout scm
				f = fileExists 'README.md'
				echo "f=${f}"
				sh 'chmod +x test.sh'
				sh 'chmod +x run.sh'
				sh 'chmod +x build.sh'
				sh 'chmod +x entrypoint.sh'
			}
		
		}
	
	}
	
	
    stage('Tests') {
		parallel {
			stage('Test On slave1') {
				when {
					expression {
						return P_SLAVE1.toString()!='NULL';
					}        
				}
			    agent {
                   label 'slave1'
                }
				steps {				
					script {				
			  
						  sh './test.sh ${P_SLAVE1}'
						
					}
				
				}
			}
			
			stage('Test On slave2') {
				when {
					expression {
						return P_SLAVE2.toString()!='NULL';
					}        
				}
			    agent {
                   label 'slave2'
                }
				steps {				
					script {					
						if(P_SLAVE1.toString()!='NULL'){			  
						  sh './test.sh ${P_SLAVE2}'
						}
					}
				
				}
			}
			
			
		}	
	}
  }
 
}
