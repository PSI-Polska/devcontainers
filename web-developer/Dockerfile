FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base:latest

ARG USERNAME=root
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
ENV CYPRESS_DOWNLOAD_PATH_TEMPLATE '${endpoint}/${platform}-${arch}/cypress.zip'

ENV LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

# Ubuntu code name matching Debian distro (see: https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian)
ARG UBUNTU_CODENAME=jammy

USER root

RUN apt-get update -yq && \
    apt-get install -yqq \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        curl \
        dnsutils \
        git \
        gpg \
        htop \
        iperf3 \
        iputils-ping \
        jq \
        lsb-release \
        mc \
        nano \
        screen \
        shellcheck \
        skopeo \
        sudo \
        tar \
        telnet \
        tmux \
        unzip \
        vim \
        wget \
        zip && \
    # Adding ansible repository \
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu ${UBUNTU_CODENAME} main" | tee /etc/apt/sources.list.d/ansible.list && \
    # Adding terraform repository
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -yqq \
        ansible \
        terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir "$USER_HOME_DIR/.kube" \
 && echo 'source <(kubectl completion bash)' >>~/.bashrc \
 && echo 'alias k=kubectl' >>~/.bash_aliases \
 && echo 'complete -o default -F __start_kubectl k' >>~/.bashrc \
 && echo 'source <(helm completion bash)' >>~/.bashrc \
 # Persisting bash history (https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history) \
 && sudo install -d -o $USERNAME -g $USERNAME /commandhistory \
 && SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
 && touch /commandhistory/.bash_history \
 && echo "$SNIPPET" >> ~/.bashrc
    
