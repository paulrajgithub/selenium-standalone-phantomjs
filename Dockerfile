FROM selenium/base:latest

#==============
# PhantomJS
#==============
RUN apt-get update -y
RUN apt-get install bzip2 libfreetype6 libfontconfig1  -y
# RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
# RUN tar -xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && rm phantomjs-2.1.1-linux-x86_64.tar.bz2
# RUN mv /phantomjs-2.1.1-linux-x86_64 /usr/local/phantomjs-2.1.1-linux-x86_64
# RUN ln -s /usr/local/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
ADD phantomjs /usr/local/bin/phantomjs
RUN chmod a+x /usr/local/bin/phantomjs

#============================
# Some configuration options
#============================
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

USER root

#====================================
# Scripts to run Selenium Standalone
#====================================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

# phantomjs will write its log here
RUN mkdir -p /var/log/selenium && chmod a+w /var/log/selenium

USER seluser

EXPOSE 4444

CMD ["/opt/bin/entry_point.sh"]
