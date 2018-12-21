FROM python:3.6.1-slim
WORKDIR /root

RUN apt-get -qq -y update && apt-get -qq -y upgrade
RUN apt-get -qq -y install     \
    awscli                     \
    build-essential            \
    curl                       \
    default-jre                \
    git-core                   \
    groff                      \
    libffi-dev                 \
    libssl-dev                 \
    make                       \
    python-dev                 \
    software-properties-common \
    wget                       \
    zip

RUN pip install -U pip setuptools wheel

RUN wget --output-document=sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip \
    && unzip sonar-scanner.zip && rm *.zip && mv sonar-scanner-*-linux sonar-scanner && ln -s `pwd`/sonar-scanner/bin/* /usr/local/bin
