<div id="top"></div>
<!-- PROJECT LOGO -->
<br />
<div align="center">
<h3 align="center">ecovadis-service</h3>

  <p align="center">
    Repository for project ecovadis risk service
    <br />
    <br />
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-project">About Project</a>
    </li>
    <li>
      <a href="#installation">Installation</a>
    </li>
    <li>
      <a href="#testing">Testing</a>
    </li>
    <li><a href="#contributing">Contributing</a></li>
  </ol>
</details>


<!-- ABOUT PROJECT -->

## About Project

Repo for Ecovadis integration at Craft

In Notion search for the following:
- Notion link to TDR
- Notion link to search usage documentation

N.B. Can't include links because trufflehog scanner thinks links are secrets...
<p align="right">(<a href="#top">back to top</a>)</p>

<!-- INSTALLATION -->

## Installation

This project uses a combination of asdf and direnv to manage dependencies and get your local environment
setup to test your code locally.

1. Install required brew dependencies
   ```sh
   brew install asdf
   brew install direnv
   brew install npm
   ```
    * assumes `brew` is installed
2. Install asdf plugins, etc
   ```sh
   asdf plugin-add python
   asdf plugin-add direnv
   asdf plugin-add terraform
   asdf install python 3.9.10
   asdf install direnv 2.30.3
   asdf install terraform  1.1.3
   ```
    * asdf requires each package to have one global set, do this if not already done
3. Export values to `~/.zshrc` file
   ```sh
   echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
   echo 'export PATH="$HOME/.asdf/shims:$PATH"' >> ~/.zshrc 
   echo 'export HOMEBREW_NO_AUTO_UPDATE=1' >> ~/.zshrc
   echo 'eval "$(asdf exec direnv hook zsh)"' >> ~/.zshrc
   echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ~/.zshrc
   ```
4. Activate virtual environment & install packages
   ```sh
   cd ecovadis-risks-esg
   asdf direnv allow (or direnv allow)
   pip install -r requirements.txt -i ${CRAFT_PYPI_URL}
   pre-commit install
   ```
   or run `make clean && install` to run with docker. 

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- TESTING -->

## Testing


1. Set up your local env according to Installation steps.
2. Run  `make dev`.
3. Navigate to Apollo Server via localhost at http://localhost:3002/graphql

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTRIBUTING -->

# Contributing

Please follow these guidelines when committing feature/bugfix/hotfix work to this project.

1. Make sure `main` branch is up-to-date (`git pull origin main` while in `main`)
2. Create your Feature Branch (`git checkout -b feature/IT2-<ticket#>-<hotfix desc>`)
3. Make changes, and then run unit and integrations tests.
4. Commit your Changes (`git commit -m 'branch name as first commit message'`)
5. Push to the Branch (`git push origin <branch name>`)
6. Open a Pull Request against `main`
7. Once qa build/deploy has been confirmed as successful, pull your feature branch into
   the `staging` branch and deploy to staging.
8. Once staging build/deploy has been confirmed as successful and the PR approved,
   ALWAYS choose `Squash and merge` option when merging PRs into `main`.

The `staging` branch is an unprotected branch used for the sole purpose of deploying to
our staging environment. If `staging` becomes wildly out of sync with `main` branch,
notify the integrations team, delete the branch in the GitHub UI, and create a new branch
based off of HEAD of `main`.

<p align="right">(<a href="#top">back to top</a>)</p>