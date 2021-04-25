"# zipline-bt for zipline based backtesting" 

# To use Zipline for testing, either install Zipline locally or use a pre-build docker image 
# making local installation of zipline is complex and diffcult to get right
# hence backtesting using zipline docker container is preferred 

# TO use DOCKER image
# ensure the environment has docker running
# ensure the environment has the zipline docker image
# if not, grab a copy of the 'stanleyu/quantopian-zipline' docker image from my docker https://hub.docker.com/
docker pull stanleyu/quantopian-zipline

# execute this command to launch the docker which will auto launch a jupyter server 
# mount backtest code in the local directory to the docker container 
# so that code can be accessed and run in jupyter via https://localhost:8888
# ~/.zipline contains the EOD data, hence to ensure
# zipline in the docker has the EOD data to work with
# the data in local directory should also be mapped to docker container
# Example given below, format is: -v <local dir>:<internal docker container dir>
docker run --rm -p:8888:8888/tcp -p:8889:8889/tcp --name zipline -v /Volumes/media/GitHub/zipline-bt/Clenow:/projects -v /Volumes/media/GitHub/zipline-bt/.zipline:/root/.zipline -v /Volumes/media/GitHub/zipline-bt/Clenow/data:/root/.zipline/Clenow/data -it stanleyu/quantopian-zipline

# Folder /Volumes/media/GitHub/zipline-bt/.zipline is a copy of
# the zipline eod data folder created by 'zipline ingest' command  

# after the container is running, use the command to login to the container
docker exec -it zipline /bin/bash

# the docker image is missing pyfolio 



                       ------------------------------------------------------------
----------------------|instructions of install zipline locally without using docker|----------------------
                       ------------------------------------------------------------
# Installation needs to be done on Linux (no Mac or Windows)
# Clone zipline source code from my own forked Github repo from https://github.com/stanleyu911/zipline.git
# check out the branch with the last zipline release 1.4.1, or simply grab a copy of the release
# source code from https://github.com/stanleyu911/zipline/releases/tag/1.4.1, and download to local drive
# Use Conda or miniconda to create a virtualenv with python v3.6, e.g. conda create -n 'zipline36' python=3.6 
# Follow the steps in the Dockerfile to install required components:

apt-get -y install libfreetype6-dev libpng-dev libopenblas-dev liblapack-dev gfortran libhdf5-dev \
    && curl -L https://downloads.sourceforge.net/project/ta-lib/ta-lib/0.4.0/ta-lib-0.4.0-src.tar.gz | tar xvz

cd ta-lib

RUN pip install 'numpy>=1.11.1,<2.0.0' \
  && pip install 'scipy>=0.17.1,<1.0.0' \
  && pip install 'pandas>=0.18.1,<1.0.0' \
  && ./configure --prefix=/usr \
  && make \
  && make install \
  && pip install TA-Lib \
  && pip install matplotlib \
  && pip install jupyter

# go to the local zipline source code directory, e.g. /Volume/media/Github/zipline
# execute 'pip install -e .'
# module 'bcolz' install will fail if installed on Mac
# do not use 'conda' to install bcolz and Pyfolio, will break the virtualenv



                       ------------------------------------------------------------
----------------------|instructions of install zipline using Anaconda              |----------------------
                       ------------------------------------------------------------
Follow Andrew Clenow's book on how to install zipline locally, or the doc at 
https://www.followingthetrend.com/2020/06/zipline-in-docker-guest-article/



                       ------------------------------------------------------------
----------------------|My Own Docker Images                                        |----------------------
                       ------------------------------------------------------------

I have these docker images:

REPOSITORY                       TAG       IMAGE ID       CREATED             SIZE
stanleyu/quantopian-zipline      latest    a62d08b615ba   About an hour ago   2.64GB
stanleyu/quantopian-base-image   latest    e0df1da6a637   About an hour ago   1.74GB
stanleyu/dashboard               v1.0      99ad26d5da94   21 hours ago        1.41GB
stanleyu/dashboard-base-image    latest    56ab752d2f59   21 hours ago        1.37GB
lhjnilsson/zipline               latest    2a17f55c9aa6   11 months ago       2.6GB
zipline                          latest    2a17f55c9aa6   11 months ago       2.6GB
stanleyu/zipline                 latest    2a17f55c9aa6   11 months ago       2.6GB

Zipline, Stanley/zipline and lhjnilsson/zipline are the same image with different tags. The image is
downloaded from https://hub.docker.com/repository/docker/lhjnilsson/zipline. It is usable but it does
Not have Pyfolio which is essential module required by Clenow's python code

Hence I created my own zipline image, they are named stanleyu/Quantopian-zipline. It uses zipline code base 
release 1.4.1, and with a modified Dockerfile that include a installation of the Pyfolio module in
the docker image. The Dockerfile is under the Docker. Just need to copy the files to the 
zipline source code folder, and run 'docker build' command to create the image







