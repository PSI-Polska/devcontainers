# BASE Image

`Dev Container` with general purpose tooling

## Selected features

* [git](https://git-scm.com/)
* [glab](https://github.com/gl-cli/glab): GitLab CLI
* network utilities (e.g.: `ping`, `telnet`, `curl`, `wget`)
* [kubectl](https://kubernetes.io/docs/reference/kubectl/) Kubernetes CLI with
  * command line completion
  * `k` alias
  * extensions and tools: [krew](https://krew.sigs.k8s.io/), [neat](https://github.com/itaysk/kubectl-neat), [kubeseal](https://github.com/bitnami-labs/sealed-secrets)
* [helm](https://helm.sh/) Kubernetes package manager with
  * command line completion
* [ansible](https://docs.ansible.com/ansible/latest/index.html)
* file archivers (`zip`, `tar`)
* editors (`vim`, `nano`)
* [velero](https://velero.io/): backup and restore for Kubernetes resources with
  * command line completion
  * `v` alias
* [mc](https://midnight-commander.org/): Midnight Commander `:-)`
