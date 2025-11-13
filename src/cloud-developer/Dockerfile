FROM ghcr.io/psi-polska/devcontainers/base

USER root
ARG USERNAME=dev

RUN echo 'Adding Google Cloud repository...' && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update && \
    apt-get install --no-install-recommends -yqq \
        google-cloud-cli \
        google-cloud-sdk-gke-gcloud-auth-plugin \
        terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    install -d -o $USERNAME -g $USERNAME /var/run/secrets

USER $USERNAME

RUN mkdir -p ~/.config/gcloud && \
    gcloud config set component_manager/disable_update_check True && \
    gcloud config set core/disable_usage_reporting True && \
    gcloud config set survey/disable_prompts True && \
    terraform -install-autocomplete