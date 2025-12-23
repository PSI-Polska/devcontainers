FROM ghcr.io/psi-polska/devcontainers/cloud-developer

USER root

# WARNING: url template given for MAVEN_URL works only for the most recent version of maven! 
ARG MAVEN_VERSION=3.9.12
ARG MAVEN_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN apt-get update -yq && \
    apt-get install --no-install-recommends -yqq \
        ca-certificates-java \
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
        temurin-11-jdk \
        temurin-17-jdk \
        temurin-21-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'Installing Maven...' && \
    mkdir -p /opt/apache-maven && \
    curl -fsSL ${MAVEN_URL} | tar -xzf - --directory /opt/apache-maven && \
    update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven/apache-maven-${MAVEN_VERSION}/bin/mvn 20

ARG USERNAME=dev
USER $USERNAME
SHELL [ "/bin/bash", "-c" ]

RUN echo "Installing nvm, node.js, nvm, angular cli..." && \
    NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/tags | jq -r '.[0].name' | cut -c 2-) && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" && \
    nvm install 16 && \
    nvm install 18 && \
    nvm alias default 18 && \
    npm install -g @angular/cli@18 && \
    echo 'Installing JEnv (https://www.jenv.be/)...' && \
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
    echo "export M2_HOME=/opt/apache-maven/apache-maven-${MAVEN_VERSION}" >>~/.bashrc && \
    echo 'export M2=$M2_HOME/bin' >>~/.bashrc && \
    echo 'export PATH=$M2:$PATH' >>~/.bashrc && \
    mkdir -p ~/.m2/repository