FROM ubuntu

MAINTAINER Zac Flamig "zflamig@uchicago.edu"

#ARG http_proxy=http://cloud-proxy:3128
#ARG https_proxy=http://cloud-proxy:3128

# Update aptitude with new repo
RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 apt-get update

# Install software 
RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 apt-get install -y \
	git \
	libjasper-dev \
	libproj-dev

RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 apt-get install -y \
        gcc \
	build-essential \
	make

RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 git clone https://github.com/zflamig/gdal.git /gdalgit
RUN cd /gdalgit/gdal && ./configure
RUN cd /gdalgit/gdal && make
RUN cd /gdalgit/gdal && make install

ENV LD_LIBRARY_PATH /usr/local/lib
ENTRYPOINT ["gdallocationinfo"]
CMD []
