FROM --platform=linux/amd64 ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

# base installations
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get install -y build-essential
RUN apt-get install -y unzip
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get update

# install python 3.10
RUN apt-get install -y python3
RUN apt-get install -y python3-venv
RUN apt-get install -y python3-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libxslt-dev
RUN apt install -y python3.7
RUN apt install -y python3.7-venv
RUN apt install -y python3.7-dev
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2

# install srcML
RUN apt-get install -y libarchive-dev
RUN apt-get install -y libarchive13
RUN ln -s /usr/lib/x86_64-linux-gnu/libarchive.so.13 /usr/lib/x86_64-linux-gnu/libarchive.so.12
RUN apt-get install -y libcurl4
#RUN wget http://131.123.42.38/lmcrs/beta/srcML-Ubuntu18.04.deb
RUN wget http://131.123.42.38/lmcrs/v1.0.0/srcml_1.0.0-1_ubuntu18.04.deb
RUN dpkg -i srcml_1.0.0-1_ubuntu18.04.deb
RUN ln -s /usr/lib/libsrcml.so.1 /usr/lib/libsrcml.so
RUN apt-get install -f -y

# install nodejsv16
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs

# TODO uncomment the following line at the end
## Download the replication package
#RUN curl -L 'https://zenodo.org/records/12567874/files/MADE-WIC.zip?download=1' -o MADE-WIC.zip
#RUN unzip MADE-WIC.zip -d MADE-WIC
#RUN rm MADE-WIC.zip

# TODO remove the following line at the end
COPY MADE-WIC MADE-WIC

# Extending the datasets
WORKDIR /MADE-WIC/Replication/extending-datasets

RUN python3 -m venv env

# . is instead of source
# the env does not stay active between two commands, therefore the env needs to be activated each time
RUN . env/bin/activate && pip install setuptools
RUN . env/bin/activate && pip install -r requirements.txt

# Clone the repos - for this demo we use only qemu, otherwise the process takes too long
WORKDIR /MADE-WIC/Replication/extending-datasets/data/repositories
RUN git clone https://github.com/qemu/qemu.git

# Copy devign sample and run the script
COPY devign_sample.json /MADE-WIC/Replication/extending-datasets/data/devign.json
WORKDIR /MADE-WIC/Replication/extending-datasets
RUN . env/bin/activate && python3 main.py -i data/devign.json -o ../devign_made-wic.csv

WORKDIR /MADE-WIC/Replication/weaksatd-annotation

RUN npm ci
# TODO fix code before continue
#RUN npm run mineProjects