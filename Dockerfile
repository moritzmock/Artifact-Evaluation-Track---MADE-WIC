FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get install -y build-essential
RUN apt-get install -y unzip

# TODO uncomment the following line at the end
#RUN curl -L 'https://zenodo.org/records/12567874/files/MADE-WIC.zip?download=1' -o MADE-WIC.zip
#RUN unzip MADE-WIC.zip -d MADE-WIC
#RUN rm MADE-WIC.zip

# TODO remove the following line at the end
COPY MADE-WIC MADE-WIC