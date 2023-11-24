#!/usr/bin/env bash

set -eu

# Check with: lychee --max-concurrency 3 del.md

GITHUB_REPOSITORIES_DESCRIPTIONS=(
  "felipegfalcao/action-my-broken-link-checker|GitHub Actions: My Broken Link Checker ✔"
  "felipegfalcao/action-my-markdown-link-checker|GitHub Actions: My Markdown Link Checker ✔"
  "felipegfalcao/action-my-markdown-linter|GitHub Actions: My Markdown Linter ✔"
  "felipegfalcao/packer-templates|Packer templates"
  "felipegfalcao/packer-virt-sysprep|Packer-Virt-Sysprep"
  "felipegfalcao/container-build|container-build"
  "felipegfalcao/darktable_video_tutorials_list|Darktable Video Tutorials with screenshots"
  "felipegfalcao/test_usb_stick_for_tv|USB Stick for TV testing"
  "felipegfalcao/ansible-role-my_common_defaults|Ansible role my_common_defaults"
  "felipegfalcao/ansible-role-proxy_settings|Ansible role proxy_settings"
  "felipegfalcao/ansible-role-virtio-win|Ansible role virtio-win"
  "felipegfalcao/ansible-role-vmwaretools|Ansible role vmwaretools"
  "felipegfalcao/ansible-my_workstation|Ansible - My Workstation"
  "felipegfalcao/ansible-openwrt|Ansible - OpenWRT"
  "felipegfalcao/ansible-raspbian|Ansible - Raspbian"
  "felipegfalcao/popular-containers-vulnerability-checks|popular-containers-vulnerability-checks"
  "felipegfalcao/malware-cryptominer-container|malware-cryptominer-container"
  "felipegfalcao/raw-photo-tools-container|raw-photo-tools-container"
  "felipegfalcao/myteam-adr|myteam-adr"
  "awsugcz/awsug.cz|Prague AWS User Group Web Pages"
  "felipegfalcao/felipegfalcao.github.io|felipegfalcao.github.io"
  "felipegfalcao/petr.ruzicka.dev|petr.ruzicka.dev"
  "felipegfalcao/xvx.cz|xvx.cz"
  "felipegfalcao/k8s-tf-eks-gitops|k8s-tf-eks-gitops"
  "felipegfalcao/k8s-eks-rancher|k8s-eks-rancher"
  "felipegfalcao/k8s-eks-bottlerocket-fargate|k8s-eks-bottlerocket-fargate"
  "felipegfalcao/k8s-flagger-istio-flux|k8s-flagger-istio-flux"
  "felipegfalcao/k8s-flux-istio-gitlab-harbor|k8s-flux-istio-gitlab-harbor"
  "felipegfalcao/k8s-harbor|k8s-harbor"
  "felipegfalcao/k8s-harbor-presentation|k8s-harbor-presentation"
  "felipegfalcao/k8s-istio-demo|k8s-istio-demo"
  "felipegfalcao/k8s-istio-webinar|k8s-istio-webinar"
  "felipegfalcao/k8s-istio-workshop|k8s-istio-workshop"
  "felipegfalcao/k8s-jenkins-x|k8s-jenkins-x"
  "felipegfalcao/k8s-knative-gitlab-harbor|k8s-knative-gitlab-harbor"
  "felipegfalcao/k8s-postgresql|k8s-postgresql"
  "felipegfalcao/k8s-sockshop|k8s-sockshop"
  "felipegfalcao/cheatsheet-macos|cheatsheet-macos"
  "felipegfalcao/cheatsheet-atom|Cheatsheet - Atom"
  "felipegfalcao/cheatsheet-systemd|Cheatsheet - Systemd"
)

for GITHUB_REPOSITORY_TITLE_TMP in "${GITHUB_REPOSITORIES_DESCRIPTIONS[@]}"; do
  GITHUB_REPOSITORY="${GITHUB_REPOSITORY_TITLE_TMP%|*}"
  GITHUB_REPOSITORY_TITLE="${GITHUB_REPOSITORY_TITLE_TMP##*|}"
  curl -s -u "${GITHUB_TOKEN}:x-oauth-basic" "https://api.github.com/repos/${GITHUB_REPOSITORY}" > /tmp/generate_projects_md.json
  GITHUB_REPOSITORY_DESCRIPTION=$(jq -r '.description' /tmp/generate_projects_md.json)
  GITHUB_REPOSITORY_HTML_URL=$(jq -r '.html_url' /tmp/generate_projects_md.json)
  GITHUB_REPOSITORY_HOMEPAGE=$(jq -r '.homepage' /tmp/generate_projects_md.json)
  GITHUB_REPOSITORY_DEFAULT_BRANCH=$(jq -r '.default_branch' /tmp/generate_projects_md.json)
  # Remove pages-build-deployment and any obsolete GitHub Actions which doesn't have path like "vuepress-build"
  GITHUB_REPOSITORY_CI_CD_STATUS=$(curl -s -u "${GITHUB_TOKEN}:x-oauth-basic" "https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/workflows" | jq -r 'del(.workflows[] | select((.path=="dynamic/pages/pages-build-deployment") or (.path==""))) | .workflows[] | "  [![GitHub Actions status - " + .name + "](" + .badge_url + ")](" + .html_url | gsub("/blob/.*/.github/"; "/actions/") + ")"' | sort --ignore-case)
  GITHUB_REPOSITORY_URL_STRING=$(if [[ -n "${GITHUB_REPOSITORY_HOMEPAGE}" ]]; then echo -e "\n- URL: <${GITHUB_REPOSITORY_HOMEPAGE}>"; fi)
  cat << EOF

## [${GITHUB_REPOSITORY_TITLE}](${GITHUB_REPOSITORY_HTML_URL})

- Description: ${GITHUB_REPOSITORY_DESCRIPTION}${GITHUB_REPOSITORY_URL_STRING}

[![GitHub release](https://img.shields.io/github/v/release/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/releases/latest)
[![GitHub license](https://img.shields.io/github/license/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/blob/${GITHUB_REPOSITORY_DEFAULT_BRANCH}/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/${GITHUB_REPOSITORY}.svg?style=social)](https://github.com/${GITHUB_REPOSITORY}/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/${GITHUB_REPOSITORY}.svg?style=social)](https://github.com/${GITHUB_REPOSITORY}/network/members)
[![GitHub watchers](https://img.shields.io/github/watchers/${GITHUB_REPOSITORY}.svg?style=social)](https://github.com/${GITHUB_REPOSITORY})

- CI/CD status:

${GITHUB_REPOSITORY_CI_CD_STATUS}

- Issue tracking:

  [![GitHub issues](https://img.shields.io/github/issues/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/issues)
  [![GitHub pull requests](https://img.shields.io/github/issues-pr/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/pulls)

- Repository:

  [![GitHub release date](https://img.shields.io/github/release-date/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/releases)
  [![GitHub last commit](https://img.shields.io/github/last-commit/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/commits/)
  [![GitHub commits since latest release](https://img.shields.io/github/commits-since/${GITHUB_REPOSITORY}/latest)](https://github.com/${GITHUB_REPOSITORY}/commits/)
  [![GitHub commit activity](https://img.shields.io/github/commit-activity/y/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY}/commits/)
  [![GitHub repo size](https://img.shields.io/github/repo-size/${GITHUB_REPOSITORY}.svg)](https://github.com/${GITHUB_REPOSITORY})
EOF
done
