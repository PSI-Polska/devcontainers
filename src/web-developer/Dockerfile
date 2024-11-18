FROM ghcr.io/psi-polska/devcontainers/cloud-developer

USER root

COPY --chmod=555 files/etc/workstation-startup.d/* /etc/workstation-startup.d/

RUN apt-get update -yq && \
    apt-get install --no-install-recommends -yqq \
        chromium \
        libgbm-dev \
        libgtk-3-0 \
        libnotify-dev \
        libxss1 \
        libxtst6 \
        xauth \
        xvfb && \
    echo 'Adding Adoptium repository...' && \
    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
    echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update -yq && \
    apt-get install -yqq \
        temurin-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG MAVEN_VERSION=3.9.9
ENV MAVEN_VERSION=${MAVEN_VERSION}
ARG MAVEN_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN echo 'Installing Maven...' && \
    mkdir -p /opt/apache-maven && \
    curl -fsSL ${MAVEN_URL} | tar -xzf - --directory /opt/apache-maven
