# Java Developer

`Dev Container` with tooling designated for Java developers using GCP

```shell
docker pull ghcr.io/psi-polska/devcontainers/java-developer
```

## Selected features

* [Adoptium JDK](https://adoptium.net/) for three versions: 11, 17 (default), 21
* [jenv](https://github.com/jenv/jenv): JDK environment manager

  ```shell
  ### Example calls
  # list available JDK versions
  jenv versions
  # change default JDK version
  jenv global 21
  # change JDK version for the current session
  jenv shell 11
  ```

* [Apache Maven](https://maven.apache.org/)

* see also
  * [base image selected features](../base/README.md#selected-features)
  * [cloud-developer image selected features](../cloud-developer/README.md#selected-features)
