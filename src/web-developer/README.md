# Java/Web Developer

`Dev Container` with tooling designated for Java and Web developers using GCP

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
* [node.js](https://nodejs.org/en), [npm](https://www.npmjs.com/), [angular CLI](https://angular.io/cli)
* [nvm](https://github.com/nvm-sh/nvm): node.js environment manager

  ```shell
  ## Example calls
  # list versions available locally
  nvm ls --no-alias
  # show current node.js version
  nvm current
  # switch to given node.js version
  nvm use 16
  ```

* see also [base image selected features](../base/README.md#selected-features)
