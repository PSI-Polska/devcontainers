FROM ghcr.io/psi-polska/devcontainers/cloud-developer

USER root

ARG MAVEN_VERSION=latest

RUN apt-get update -yq && \
    apt-get install --no-install-recommends -yqq \
        ca-certificates-java && \
    echo 'Adding Adoptium repository...' && \
    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
    echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update -yq && \
    apt-get install -yqq \
        temurin-11-jdk \
        temurin-17-jdk \
        temurin-21-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'Installing Maven...' && \
    if [ "$MAVEN_VERSION" = "latest" ]; then \
        MAVEN_VERSION=$(curl -s https://maven.apache.org/download.cgi | grep -o 'apache-maven-[0-9.]*-bin.tar.gz' | head -1 | sed 's/apache-maven-\(.*\)-bin.tar.gz/\1/'); \
    fi && \
    mkdir -p /opt/apache-maven && \
    curl -fsSL "https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" | tar -xzf - --directory /opt/apache-maven && \
    ln -s /opt/apache-maven/apache-maven-${MAVEN_VERSION} /opt/apache-maven/current && \
    update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven/current/bin/mvn 20

ARG USERNAME=dev
USER $USERNAME

RUN echo 'Installing JEnv (https://www.jenv.be/)...' && \
    git clone https://github.com/jenv/jenv.git ~/.jenv && \
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >>~/.bashrc && \
    echo 'eval "$(jenv init -)"' >>~/.bashrc && \
    export PATH="$HOME/.jenv/bin:$PATH" && \
    eval "$(jenv init -)" && \
    jenv enable-plugin export && \
    jenv enable-plugin maven && \
    jenv add /usr/lib/jvm/temurin-11-jdk-amd64 && \
    jenv add /usr/lib/jvm/temurin-17-jdk-amd64 && \
    jenv add /usr/lib/jvm/temurin-21-jdk-amd64 && \
    jenv global 17 && \
    echo 'export M2_HOME=/opt/apache-maven/current' >>~/.bashrc && \
    echo 'export M2=$M2_HOME/bin' >>~/.bashrc && \
    echo 'export PATH=$M2:$PATH' >>~/.bashrc && \
    mkdir -p ~/.m2/repository