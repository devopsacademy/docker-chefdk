FROM       devoaca/ubuntu:latest
MAINTAINER Mauricio Araya

ENV LANGUAGE=en_US
ENV LANG=en_US.UTF-8

ENV CHEFDK_VERSION='4.2.0-1'

RUN apt-get update

# RUN curl -s https://packages.chef.io/chef.asc | \
#          apt-key add - && \
#     echo 'deb https://packages.chef.io/repos/apt/stable bionic main' | \
#          tee /etc/apt/sources.list.d/chef-stable.list && \
#          apt-get update && \
#          apt-get install chefdk

RUN wget --quiet --output-document /tmp/chefdk.deb \
         "https://packages.chef.io/repos/apt/stable/ubuntu/18.04/chefdk_${CHEFDK_VERSION}_amd64.deb"

RUN dpkg -i /tmp/chefdk.deb && rm -f /tmp/chefdk.deb

RUN gem install --no-doc --no-ri bundler

RUN apt-get clean -y && rm -rf /root/.gem

RUN useradd -m -d /home/chefdk -s /bin/bash -c ChefDK chefdk && \
    mkdir -p /home/chefdk/.ssh /home/chefdk/.chef /home/chefdk/workdir

RUN mkdir -p /usr/local/share
COPY git-prompt.sh /usr/local/share/git-prompt.sh
RUN chmod 644 /usr/local/share/git-prompt.sh

COPY bashrc /home/chefdk/.bashrc
COPY bash_logout /home/chefdk/.bash_logout
COPY inputrc /etc/inputrc
RUN chmod 644 /etc/inputrc

RUN chown -R chefdk:chefdk /home/chefdk && \
    find /home/chefdk -type d | xargs chmod -v 700 && \
    find /home/chefdk -type f | xargs chmod -v 600

WORKDIR /home/chefdk/workdir

ENTRYPOINT ["/bin/bash"]
