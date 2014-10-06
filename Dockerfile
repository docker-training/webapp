FROM ubuntu:14.04
MAINTAINER Docker Education Team <education@docker.com>
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-all python-pip 
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
