# Apache Druid custom docker image
a custom single node lates apache druid docker image that is ready to use without any custom configs.

## Running from dockerhub 
	docker pull mujahid002/apache-superset:latest

and then run it by

	docker run -d -p 8888:8888 --name druid mujahid002/druid:latest

## How to Build:
use the following command to build the image

	git clone https://github.com/mujahidniaz/apache-druid-docker.git
	cd apache-druid-docker
	docker build -t mujahid002/druid .

Then you can run the container using:

	docker run --name my_superset -d -p 8888:8888 mujahid002/druid
		
Now finally open your browser and type

	http://localhost:8888/
		