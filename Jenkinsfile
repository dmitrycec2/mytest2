def BRANCH_NAME = 'main'
pipeline {
  parameters { // {
    choice(
      name: 'P_SLAVE1',
      description: '',
      choices: ['NULL', 'enable'] as List
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
      choices: ['NULL', 'slave1'] as List
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
				sh 'chmod +x tests/trivial/UC02_run'
				
			}
		
		}
	
	}
	
	
    stage('Tests') {
		parallel {
			stage('UC01') {
				when {
					beforeAgent true;
					expression {
						return P_UC01.toString()!='NULL';
					}        
				}
			    agent {
                   label "${P_UC01}"
                }
				steps {				
					script {				
			  
						  sh './test.sh UC01_run'
						
					}
				
				}
			}
			
			stage('UC02') {
				when {
					beforeAgent true;
					expression {
						return P_UC02.toString()!='NULL';
					}        
				}
			    agent {
                   label "${P_UC02}"
                }
				steps {				
					script {					
			  
						  sh './test.sh UC_251_NEWFILE_run'
						
					}
				
				}
			}
			
			
		}	
	}
  }
 
}
