## Python Builds

This project provides several selected python versions as one docker image. If you need a jenkins build pipeline you might use the following.

``` groovy
pipeline
{
  agent
  {
     docker
     {
        image 'rkhullar/python-builds:1.0.1'
     }
  }
  stages
  {
    stage('Example')
    {
      steps
      {
        sh 'pyenv local 3.7.5'
        sh 'pip install -U pip setuptools'
        sh 'sonar-scanner -v'
      }
    }
  }
}
```

### Utility Programs
| Package      | Description                    |
| ------------ | ------------------------------ |
| acl          | fine grain file access control |
| bash         | shell                          |
| curl         | http requests                  |
| git          | version control                |
| jq           | json query                     |
| make         | makefiles                      |
| nano         | text editor                    |
| openjdk8-jre | java run time                  |
| sudo         | privilege escalation           |
| unzip        | file archiver                  |
| vim          | text editor                    |
| wget         | http downloader                |
| zip          | file archiver                  |
