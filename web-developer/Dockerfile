FROM ghcr.io/psi-polska/devcontainers/cloud-developer

ARG USER_HOME_DIR="/root"

ARG MAVEN_VERSION=3.9.7
ARG MAVEN_BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

ARG FIREFOX_VERSION=114.0

USER root

ENV JAVA_HOME /usr/lib/jvm/temurin-17-jdk-amd64
RUN echo "JAVA_HOME=${JAVA_HOME}"

# Install Chromium
RUN echo "Installing Chromium..." \
 && apt update && apt install chromium -y \
 && ln -s /usr/bin/chromium /usr/local/bin/chromium-browser

# Install Maven
RUN echo 'Installing Maven...' \
 && mkdir -p /usr/share/maven /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Install Angular
RUN echo "Installing Angular..." && \
    npm install -g @angular/cli@18

# Install Cepress
RUN echo 'Installing cypress dependencies..' && \
    apt-get update && \
    apt-get install --no-install-recommends -qy \
        libgtk-3-0 \
        libgbm-dev \
        libnotify-dev \
        libxss1 \
        libxtst6 \
        xauth \
        xvfb && \
    rm -rf /var/lib/apt/lists/*
ENV CYPRESS_DOWNLOAD_MIRROR https://cdn.cypress.io
ENV CYPRESS_DOWNLOAD_USE_CA true
ENV CYPRESS_DOWNLOAD_PATH_TEMPLATE "\${endpoint}/\${platform}-\${arch}/cypress.zip"
