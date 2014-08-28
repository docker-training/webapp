FROM ubuntu:12.04
MAINTAINER Docker Education Team <education@docker.com>
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl python-all python-pip wget
ADD ./webapp/requirements.txt /opt/webapp/requirements.txt
WORKDIR /opt/webapp
RUN pip install -r requirements.txt
ADD ./webapp /opt/webapp/
EXPOSE 5000
CMD ["python", "app.py"]
