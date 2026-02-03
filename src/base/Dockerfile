FROM debian:bookworm-slim

ARG USERNAME=dev
ARG USER_UID=1001
ARG USER_GID=1001
# debian:bookworm => ubuntu:jammy (https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian)
ARG UBUNTU_CODENAME='jammy'

ENV LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

USER root

COPY files/certs/*.crt /usr/local/share/ca-certificates/

RUN apt-get update -yq && \
    apt-get install --no-install-recommends -yqq \
        apt-transport-https \
        apt-utils \
        bash-completion \
        ca-certificates \
        chromium \
        curl \
        dnsutils \
        git \
        gpg \
        htop \
        iperf3 \
        iputils-ping \
        jq \
        libgbm-dev \
        libgtk-3-0 \
        libnotify-dev \
        libxss1 \
        libxtst6 \
        lsb-release \
        mc \
        nano \
        pre-commit \
        procps \
        python3 \
        python3-pip \
        python3-venv \
        rsync \
        screen \
        shellcheck \
        skopeo \
        sudo \
        tar \
        telnet \
        tmux \
        unzip \
        uuid \
        vim \
        wget \
        xauth \
        xvfb \
        yamllint \
        zip && \
    echo 'Adding ansible repository...' && \
        wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | \
            gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg && \
        echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu ${UBUNTU_CODENAME} main" | \
            tee /etc/apt/sources.list.d/ansible.list && \
    echo 'Installing ArgoCD CLI...' && \
        ARGOCD_VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION) && \
        curl -sSL https://github.com/argoproj/argo-cd/releases/download/v$ARGOCD_VERSION/argocd-linux-amd64 -o argocd-linux-amd64 && \
        install -m 555 argocd-linux-amd64 /usr/local/bin/argocd && rm ./argocd-linux-amd64 && \
    echo 'Adding docker repository...' && \
        install -m 0755 -d /etc/apt/keyrings && \
        curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
        chmod a+r /etc/apt/keyrings/docker.asc && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
            $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    echo 'Installing GitLab CLI (glab)...' && \
        GLAB_VERSION=$(curl -s https://api.github.com/repos/gitlabhq/cli/tags | jq -r '.[0].name' | cut -c 2-) && \
        curl -L https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.deb -o glab_${GLAB_VERSION}_linux_amd64.deb && \
        dpkg -i ./glab_${GLAB_VERSION}_linux_amd64.deb && \
        rm ./glab_${GLAB_VERSION}_linux_amd64.deb && \
    echo 'Installing helm...' && \
        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
    echo "Adding kubectl repository..." && \
        KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt | cut -c -5)" && \
        curl -fsSL https://pkgs.k8s.io/core:/stable:/${KUBECTL_VERSION}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
        echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBECTL_VERSION}/deb/ /" | \
            tee /etc/apt/sources.list.d/kubernetes.list && \
    echo 'Adding terraform repository...' && \
        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
            tee /etc/apt/sources.list.d/hashicorp.list && \
    echo 'Adding trivy repository...' && \
        wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | tee /usr/share/keyrings/trivy.gpg > /dev/null && \
        echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | tee -a /etc/apt/sources.list.d/trivy.list && \
    echo 'Installing velero...' && \
        VELERO_VERSION="$(basename $(curl -Ls -o /dev/null -w '%{url_effective}' https://github.com/vmware-tanzu/velero/releases/latest))" && \
        curl -L https://github.com/vmware-tanzu/velero/releases/download/${VELERO_VERSION}/velero-${VELERO_VERSION}-linux-amd64.tar.gz | \
            tar --directory /usr/bin/ --strip-components=1 -xzf - velero-${VELERO_VERSION}-linux-amd64/velero && \
    echo 'Installing kubeseal...' && \
        KUBESEAL_VERSION=$(curl -s https://api.github.com/repos/bitnami-labs/sealed-secrets/tags | jq -r '.[0].name' | cut -c 2-) && \
        curl -L "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz" | tar -xzf - kubeseal && \
        install -m 755 kubeseal /usr/local/bin/kubeseal && rm ./kubeseal && \
    apt-get update -yq && \
    apt-get install -yqq \
        ansible \
        docker-ce-cli \
        docker-buildx-plugin \
        docker-compose-plugin \
        kubectl \
        trivy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    install -d -o $USERNAME -g $USERNAME /commandhistory && \
    echo 'git: mark all directories as safe' && \
    git config --system --add safe.directory '*' && \
    update-ca-certificates

USER $USERNAME
SHELL [ "/bin/bash", "-c" ]

RUN curl https://raw.githubusercontent.com/devcontainers/features/refs/heads/main/src/common-utils/scripts/bash_theme_snippet.sh >>~/.bashrc && \
    mkdir -p ~/.kube && \
    echo 'source <(argocd completion bash)' >>~/.bashrc && \
    echo 'source <(glab completion -s bash)' >>~/.bashrc && \
    echo 'source <(helm completion bash)' >>~/.bashrc && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    echo 'alias k=kubectl' >>~/.bash_aliases && \
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc && \
    echo 'source <(velero completion bash)' >>~/.bashrc && \
    echo 'alias v=velero' >>~/.bash_aliases && \
    echo 'complete -F __start_velero v' >>~/.bashrc && \
    echo 'Installing kubectl krew extension...' && \
        OS="$(uname | tr '[:upper:]' '[:lower:]')" && \
        ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && \
        KREW="krew-${OS}_${ARCH}" && \
        curl -fsSL "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" | sudo tar -xzf - ./${KREW} && \
        ./${KREW} install krew && sudo rm ./${KREW} && \
        echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >>~/.bashrc && \
    echo 'Installing kubectl neat extension...' && \
        export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" && \
        kubectl krew install neat && \
    # Persisting bash history (https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history)
    touch /commandhistory/.bash_history && \
    echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" >> ~/.bashrc && \
    echo "Installing nvm, node.js, nvm, angular cli..." && \
    NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/tags | jq -r '.[0].name' | cut -c 2-) && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" && \
    nvm install 18 && \
    nvm install 20 && \
    nvm install 22 && \
    nvm install 24 && \
    nvm alias default 24 && \
    npm install -g @angular/cli@21