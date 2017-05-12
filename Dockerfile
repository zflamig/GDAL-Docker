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
	libproj-dev \
	gcc build-essential make wget m4 zlib1g-dev

RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 wget https://www.hdfgroup.org/package/bzip2/?wpdmdl=4300
RUN mv "index.html?wpdmdl=4300" hdf5-1.10.1.tar.bz2 && tar xf hdf5-1.10.1.tar.bz2
RUN cd hdf5-1.10.1 && ./configure --prefix=/usr --enable-cxx --with-zlib=/usr/include,/usr/lib/x86_64-linux-gnu && make -j4 && make install

RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 wget https://github.com/Unidata/netcdf-c/archive/v4.4.1.1.tar.gz
RUN tar xf v4.4.1.1.tar.gz
RUN cd netcdf-c-4.4.1.1 && ./configure  && make -j4 && make install 

RUN http_proxy=http://cloud-proxy:3128 https_proxy=http://cloud-proxy:3128 git clone https://github.com/zflamig/gdal.git /gdalgit
RUN cd /gdalgit/gdal && ./configure
RUN cd /gdalgit/gdal && make -j4
RUN cd /gdalgit/gdal && make install

ENV LD_LIBRARY_PATH /usr/local/lib
ENTRYPOINT ["gdallocationinfo"]
CMD []
