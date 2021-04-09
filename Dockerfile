FROM ubuntu:18.04
ENV http_proxy 10.194.10.21:3128
ENV https_proxy 10.194.10.21:3128
# add proxy configuration for apt
RUN echo 'Acquire::http::Proxy "http://10.194.10.21:3128/";' >> /etc/apt/apt.conf.d/proxy.conf; \
echo 'Acquire::https::Proxy "http://10.194.10.21:3128/";' >> /etc/apt/apt.conf.d/proxy.conf
RUN apt-get update; apt-get install -y curl zip unzip
RUN rm /bin/sh; ln -s /bin/bash /bin/sh
RUN curl -s "https://get.sdkman.io" | bash; \
source "$HOME/.sdkman/bin/sdkman-init.sh"; \
sdk version; \
sdk install java 11.0.10-zulu; \
java -version
COPY dockerdemo*.jar /dockerdemo.jar
COPY apprun.sh /apprun.sh
RUN chmod +x /apprun.sh
ENTRYPOINT ["/bin/bash","/apprun.sh"]