FROM python:3.6.1-slim
WORKDIR /root

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    awscli                               \
    build-essential                      \
    curl                                 \
    default-jre                          \
    git-core                             \
    groff                                \
    libffi-dev                           \
    libssl-dev                           \
    make                                 \
    python-dev                           \
    software-properties-common           \
    wget                                 \
    zip                                  \
&& rm -rf /var/lib/apt/lists/*

RUN pip install -U pip setuptools wheel

RUN wget --output-document=sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip \
    && unzip sonar-scanner.zip && rm *.zip && mv sonar-scanner-*-linux sonar-scanner && ln -s `pwd`/sonar-scanner/bin/* /usr/local/bin
