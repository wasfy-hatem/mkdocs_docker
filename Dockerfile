FROM centos:7

MAINTAINER wasfy

LABEL Remarks="testing for assigning docker data by Wasfy"


RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

#just in case
RUN export LC_ALL=en_US.utf-8
RUN export LANG=en_US.utf-8


RUN yum -y update && \

yum -y install httpd && \

yum clean all

#RUN wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz

#RUN sudo tar -C /usr/local -xzf go1.13.linux-amd64.tar.gz

#RUN export PATH=$PATH:/usr/local/go/bin

RUN source ~/.bash_profile

RUN yum -y install gcc
RUN yum -y install gcc-c++

#wa dir -----------
RUN yum update -y \
    && yum install -y https://repo.ius.io/ius-release-el7.rpm \
    && yum install -y python36u python36u-libs python36u-devel python36u-pip \
    && yum install -y which gcc \
    && yum install -y openssh git \

RUN pip3.6 install pipenv
RUN ln -s /usr/bin/pip3.6 /bin/pip
RUN rm /usr/bin/python
# python must be pointing to python3.6
RUN ln -s /usr/bin/python3.6 /usr/bin/python

RUN pip3.6 install --upgrade pip
RUN pip3.6 install mkdocs

#run mkdocs proj
WORKDIR /tmp
RUN pwd
RUN mkdocs new my-project
RUN cd ./my-project
ADD ./my-project  .
# ADD local drive folder ---- container folder
RUN ls -la
RUN pwd

WORKDIR /tmp/my-project
RUN ls -la
RUN pwd



###RUN mkdocs serve


#WORKDIR /opt/intranet

##WORKDIR /opt/intranet
##COPY Pipfile /opt/intranet/

#RUN pipenv install --python `which python3.6` --system



#-----------------


##ADD ./code /code

###EXPOSE 36666

##ENV HOME /root

##WORKDIR /root

##COPY ./runme /
##ENTRYPOINT ["/runme"]
#CMD []

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]

