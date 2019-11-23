FROM alpine:3.9
MAINTAINER Rajan Khullar

RUN apk add --no-cache \
    acl             \
    bash            \
    curl            \
    git             \
    jq              \
    make            \
    nano            \
    openjdk8-jre    \
    sudo            \
    unzip           \
    vim             \
    wget            \
    zip

WORKDIR /opt

# install sonar scanner
ENV SONAR_CLI_VERSION 3.4.0.1729
RUN wget --output-document=sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_CLI_VERSION}-linux.zip \
    && unzip sonar-scanner.zip && rm *.zip && mv sonar-scanner-*-linux sonar-scanner \
    && sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner/bin/sonar-scanner \
    && rm -rf /opt/sonar-scanner/jre

ENV SONAR_CLI_HOME /opt/sonar-scanner
ENV PATH "$SONAR_CLI_HOME/bin:$PATH"

# install pyenv
ENV PYENV_CLI_VERSION 'v1.2.15'
RUN wget --output-document=pyenv.zip https://github.com/pyenv/pyenv/archive/${PYENV_CLI_VERSION}.zip && unzip pyenv.zip \
    && rm *.zip && mv pyenv-* pyenv

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN apk add --no-cache \
    build-base      \
    libffi-dev      \
    openssl-dev     \
    bzip2-dev       \
    zlib-dev        \
    readline-dev    \
    sqlite-dev

WORKDIR /root
ENV DEFAULT_PYTHON_VERSION 3.7.5
COPY versions.txt .
ADD install-python.sh .
RUN ./install-python.sh
RUN chmod -R 777 $PYENV_ROOT/versions $PYENV_ROOT/shims
