FROM ubuntu:14.04.update
MAINTAINER Landers
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp
EXPOSE 5000
CMD ["python", "app.py"]

