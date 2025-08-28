# BASE Image

`Dev Container` with general purpose tooling

```shell
docker pull ghcr.io/psi-polska/devcontainers/base
```

## Selected features

* editors (`vim`, `nano`)
* file archivers (`zip`, `tar`)
* network utilities (e.g.: `ping`, `telnet`, `curl`, `wget`)
* [ansible](https://docs.ansible.com/ansible/latest/index.html): automation for remote systems management
* [argocd](https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd/): ArgoCD CLI with
  * command line completion
* [git](https://git-scm.com/): distributed version control system
* [glab](https://github.com/gl-cli/glab): GitLab CLI
* [helm](https://helm.sh/): Kubernetes package manager with
  * command line completion
* [kubectl](https://kubernetes.io/docs/reference/kubectl/): Kubernetes CLI with
  * command line completion
  * `k` alias
  * extensions and tools: [krew](https://krew.sigs.k8s.io/), [neat](https://github.com/itaysk/kubectl-neat), [kubeseal](https://github.com/bitnami-labs/sealed-secrets)
* [mc](https://midnight-commander.org/): Midnight Commander `:-)`
* [velero](https://velero.io/): backup and restore for Kubernetes resources with
  * command line completion
  * `v` alias
