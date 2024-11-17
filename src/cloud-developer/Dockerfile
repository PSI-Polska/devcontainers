# Preconfigured base images: https://cloud.google.com/workstations/docs/preconfigured-base-images
# Customize container images: https://cloud.google.com/workstations/docs/customize-container-images
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base:latest

ENV LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

USER root

COPY --chmod=555 files/etc/workstation-startup.d/* /etc/workstation-startup.d/

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
    # Install Docker CLI
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    # Adding ansible repository
    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ansible.list && \
    # Adding terraform repository
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -yqq \
        docker-ce-cli \
        docker-buildx-plugin \
        docker-compose-plugin \
        ansible \
        terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # git: mark all directories as safe
    git config --system --add safe.directory '*'

    ENTRYPOINT ["/google/scripts/entrypoint.sh"]
    CMD [ "sleep", "infinity" ]
