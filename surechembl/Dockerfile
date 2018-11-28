FROM debian:stretch-slim

LABEL maintainer="arcila@ebi.ac.uk"

ADD oracle-instantclient*.rpm /tmp/
ADD test.py /opt/

SHELL ["/bin/bash", "-c"]

RUN apt-get -qq update && apt-get -y -qq upgrade && \
    apt-get -y -qq install alien wget libaio1 gettext git locales && \
    sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen && \
    echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc && \
    echo "export LANG=en_US.UTF-8" >> ~/.bashrc && \
    echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc && \
    alien /tmp/oracle-instantclient18.3-* && \
    rm -f /tmp/oracle-instantclient*.rpm && \    
    dpkg -i oracle-instantclient*.deb && \
    echo /usr/lib/oracle/18.3/client64/lib > /etc/ld.so.conf.d/oracle-instantclient18.3.conf && \
    ldconfig

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    /opt/conda/bin/conda create -n surechembl python=2.7 --yes && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate surechembl" >> ~/.bashrc


ENV TNS_ADMIN=/usr/lib/oracle/18.3/client64 \
    ORACLE_HOME=/usr/lib/oracle/18.3/client64 \
    PATH=$PATH:/usr/lib/oracle/18.3/client64/bin

ADD tnsnames.ora /usr/lib/oracle/18.3/client64

ADD fireitup.sh /
RUN chmod 755 /fireitup.sh

EXPOSE 8000

ENTRYPOINT [ "./fireitup.sh" ]