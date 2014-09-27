JenkinsRubyDockerfile
=====================

A Dockerfile for creating a Jenkins instance that is ready for  Ruby builds 

Suffers from Image bloat though so need to investigate how can create a more optimised image before pushing image up to hub

TODO:
 
* Create guidance notes
* Test RVM configuration
* provide guidance on using a volume to keep config etc



		To build image :
		docker build -t JenkinsRuby .

		To run container:
		Docker run -p 8080:8080 -d -t JenkinsRuby



Notes:

should use nginx or behind apache if setting up webhooks with github!
