FROM ubuntu
MAINTAINER Jerome Baum "jerome@jeromebaum.com"

RUN echo "root:root" | chpasswd

ENV VERSION 2.14
ENV TARBALL shellinabox-$VERSION.tar.gz

RUN apt-get -qq -y install \
    gcc make && \
    apt-get clean

ADD http://shellinabox.googlecode.com/files/$TARBALL /tmp/
RUN cd /tmp && \
    tar xf /tmp/$TARBALL && \
    cd /tmp/shellinabox-$VERSION/ && \
    ./configure && \
    make && \
    make install && \
    mkdir /etc/shellinabox-css && \
    cp shellinabox/*.css /etc/shellinabox-css/

ADD setup.sh /setup.sh
RUN /setup.sh

CMD ["shellinaboxd", "-s", "/:LOGIN", "--disable-ssl", "--user-css", "Normal:+/etc/shellinabox-css/white-on-black.css,Reverse:-/etc/shellinabox-css/black-on-white.css"]
EXPOSE 4200
