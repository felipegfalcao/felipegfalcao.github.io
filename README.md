# felipegfalcao.github.io

[![GitHub Actions status - Lint Code Base](https://github.com/felipegfalcao/felipegfalcao.github.io/actions/workflows/mega-linter.yml/badge.svg)](https://github.com/felipegfalcao/felipegfalcao.github.io/actions/workflows/mega-linter.yml)
[![Build and Deploy](https://github.com/felipegfalcao/felipegfalcao.github.io/actions/workflows/gh-pages-build.yml/badge.svg?branch=main)](https://github.com/felipegfalcao/felipegfalcao.github.io/actions/workflows/gh-pages-build.yml)

## Overview

My personal site and blog...

[**felipegfalcao.github.io**](https://felipegfalcao.github.io/)

- Main Page: <https://felipegfalcao.github.io>, <https://felipegfalcao.github.io>
- Dev Page: <https://felipegfalcao.github.io>

## Theme Source

Chirpy:

- [GitHub](https://github.com/cotes2020/jekyll-theme-chirpy)
- [Example and tips/best practices](https://chirpy.cotes.page/)

## Building / Testing Locally

On Ubuntu / Intel-based Mac:

```bash
bundle install
bundle exec jekyll s
```

Using Docker:

```bash
docker run --rm -it --volume="${PWD}:/srv/jekyll:Z" --publish 4000:4000 jekyll/jekyll jekyll serve
```

Megalinter:

```bash
mega-linter-runner --flavor documentation \
  -e "'DISABLE_LINTERS=REPOSITORY_DEVSKIM,SPELL_CSPELL'" \
  -e BASH_SHFMT_ARGUMENTS="--indent 2 --space-redirects" \
  -e FORMATTERS_DISABLE_ERRORS="false" \
  -e HTML_HTMLHINT_FILTER_REGEX_EXCLUDE="^index.html" \
  -e JSON_PRETTIER_FILTER_REGEX_EXCLUDE="^.markdown-link-check.json" \
  -e MARKDOWN_MARKDOWNLINT_CONFIG_FILE=".markdownlint.yml" \
  -e PRINT_ALPACA="false" \
  -e REPORT_OUTPUT_FOLDER="/tmp/" \
  -e RUBY_RUBOCOP_FILTER_REGEX_EXCLUDE="^_plugins" \
  -e SPELL_CSPELL_FILTER_REGEX_INCLUDE="(^README.md|^_posts/)" \
  -e SPELL_MISSPELL_FILTER_REGEX_EXCLUDE="^_data/locales" \
  -e YAML_PRETTIER_FILTER_REGEX_EXCLUDE="(^_data/|^_config.yml)" \
  -e YAML_V8R_FILTER_REGEX_EXCLUDE="(^_data/|^_config.yml)"
```

## Notes

- Use ` ```bash ` to run commands during the post_tests
  "create" execution:

  ````md
  ```bash
  ### <some create commands...>
  ```
  ````

- Use ` ```shell ` not to run commands during the post_tests
  execution (they will be only displayed on the web pages):

  ````md
  ```shell
  ### some commands...
  ```
  ````

- Use ` ```sh` to run commands during the post_tests
  "destroy" execution:

  ````md
  ```sh
  ### <some clean-up/destroy commands...>
  ```
  ````
