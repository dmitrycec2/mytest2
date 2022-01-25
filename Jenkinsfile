def BRANCH_NAME = 'main'
def tasks = [:]

tasks["task_1"] = {
  stage ("task_1"){    
    node('slave1') {  
        sh 'echo ---------------- $NODE_NAME'
    }
  }
}
tasks["task_2"] = {
  stage ("task_2"){    
    node('slave1') {  
        sh 'echo ------------- $NODE_NAME'
    }
  }
}
pipeline {
  parameters { // {
    choice(
      name: 'P_SLAVE1',
      description: '',
      choices: ['enable', 'NULL'] as List
    )
    choice(
      name: 'P_SLAVE2',
      description: '',
      choices: ['NULL', 'enable'] as List
    )
    choice(
      name: 'P_UC01',
      description: '',
      choices: ['NULL', 'slave1'] as List
    )	
    choice(
      name: 'P_UC02',
      description: '',
      choices: ['slave1', 'NULL'] as List
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
		beforeAgent true;
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
				sh './build.sh'
			}
		
		}
	
	}
	stage('Build On slave2') {
	when {
		beforeAgent true;
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
				sh 'build.sh'
				sh './build.sh'
				
			}
		
		}
	
	}
	
	
    stage('Tests') {
		parallel {
			stage('Test On slave1') {
				when {
					beforeAgent true;
					expression {
						return P_SLAVE1.toString()!='NULL';
					}        
				}
			    agent {
                   label 'slave1'
                }
				
					steps {	
						
							script {					
								
									parallel tasks								
								
								
							}
						
					
					}
			}
			
			stage('Test On slave2') {
				when {
					beforeAgent true;
					expression {
						return P_SLAVE2.toString()!='NULL';
					}        
				}
			    agent {
                   label 'slave1'
                }
				steps {				
					script {					
						if(P_UC02.toString()!='NULL'){			  
						  sh './test.sh UC02_run'
						}
					}
				
				}
			}
			
			
		}	
	}
  }
 
}
