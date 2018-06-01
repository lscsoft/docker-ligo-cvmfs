FROM ligo/base:jessie

LABEL name="LIGO Software Environment for Debian Jessie with user shell" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170608" \
      support="Reference Platform"

COPY /environment/cvmfs/default.local /etc/cvmfs/default.local
COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /environment/etc/fstab /etc/fstab
COPY /environment/sudoers.d/albert /etc/sudoers.d/albert
COPY /entrypoint/startup /usr/local/bin/startup

RUN apt-get update && \
    apt-get install --assume-yes curl lsb-release

RUN curl -L -O -J https://download.opensuse.org/repositories/home:/drdaved:/cvmfs-contrib/Debian_8.0/all/cvmfs-contrib-release_1.4.1_all.deb && \
    dpkg -i cvmfs-contrib-release_1.4.1_all.deb && \
    rm -f cvmfs-contrib-release_1.4.1_all.deb && \
    curl -L -O -J https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb && \
    dpkg -i cvmfs-release-latest_all.deb && \
    rm -f cvmfs-release-latest_all.deb

RUN apt-get update && \
    apt-get install --assume-yes \
      cvmfs \
      cvmfs-config-osg \
      cvmfs-x509-helper \
      ldg-client \
      sudo \
      vim && \
    apt-get clean

RUN mkdir /cvmfs/config-osg.opensciencegrid.org && \
    mkdir /cvmfs/oasis.opensciencegrid.org && \
    mkdir /cvmfs/singularity.opensciencegrid.org && \
    mkdir /cvmfs/ligo.osgstorage.org && \
    mkdir /container

RUN useradd -m -d /container/albert -s /bin/bash albert
USER albert
WORKDIR /container/albert
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["/bin/bash", "-l" ]
