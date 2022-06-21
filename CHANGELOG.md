# Changelog

All notable changes to this project will be documented in this file.
This project *loosely tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

## [0.8.7] - 2022-06-21
- [#63](https://github.com/boltops-tools/kubes/pull/63) remove kubes meta from yaml
- adjust app layer. keep old layer also for now though

## [0.8.6] - 2022-02-16
- [#62](https://github.com/boltops-tools/kubes/pull/62) config map files: add Kubes.app txt layer

## [0.8.5] - 2022-02-16
- [#61](https://github.com/boltops-tools/kubes/pull/61) add erb support for config_map_files and generic_secret_data helpers

## [0.8.4] - 2022-02-16
- bump kubes_aws and kubes_google dependencies

## [0.8.3] - 2022-02-16
- [#60](https://github.com/boltops-tools/kubes/pull/60) Config files

## [0.8.2] - 2022-02-07
- improve gem dependency version specifiers

## [0.8.1] - 2022-02-06
- allow --version command to run outside project

## [0.8.0] - 2022-02-06
- [#58](https://github.com/boltops-tools/kubes/pull/58) standalone install docs
- [#59](https://github.com/boltops-tools/kubes/pull/59) central deployer support

## [0.7.10] - 2021-12-18
- [#56](https://github.com/boltops-tools/kubes/pull/56) New hook generator
- [#57](https://github.com/boltops-tools/kubes/pull/57) Fix activesupport require
- add nokogiri dependency. looks like aws-sdk removed it and its breaking specs
- hook generator docs
- new hook generator

## [0.7.9] - 2021-11-07
- [#55](https://github.com/boltops-tools/kubes/pull/55) make helper methods available in variables files

## [0.7.8] - 2021-10-29
- [#54](https://github.com/boltops-tools/kubes/pull/54) fix configMap and secret hash when not first element in Array

## [0.7.7] - 2021-10-21
- [#51](https://github.com/boltops-tools/kubes/pull/51) add hash checksum for tls secretName
- [#52](https://github.com/boltops-tools/kubes/pull/52) add role all layer to pre_layers
- [#53](https://github.com/boltops-tools/kubes/pull/53) Merger options

## [0.7.6] - 2021-10-12
- remove init yaml templates, removed duplication
- write full.yaml to .kubes/tmp instead

## [0.7.5] - 2021-06-03
- [#47](https://github.com/boltops-tools/kubes/pull/47) add search
- [#48](https://github.com/boltops-tools/kubes/pull/48) use deep_merge overwrite_arrays option fixes #45

## [0.7.4] - 2021-03-02
- [#46](https://github.com/boltops-tools/kubes/pull/46) call run method to respect config.suffix_hash

## [0.7.3] - 2020-12-24
- [#44](https://github.com/boltops-tools/kubes/pull/44) require singleton

## [0.7.2] - 2020-12-04
- [#43](https://github.com/boltops-tools/kubes/pull/43) store docker image name in env based folder
- fix kubes help

## [0.7.1] - 2020-11-16
- [#42](https://github.com/boltops-tools/kubes/pull/42) load helpers for dsl properly
- fix merge layer

## [0.7.0] - 2020-11-16
- [#41](https://github.com/boltops-tools/kubes/pull/41) multiple resources yaml support

## [0.6.8] - 2020-11-14
- [#40](https://github.com/boltops-tools/kubes/pull/40) fix version check

## [0.6.7] - 2020-11-12
- dependencies version bump: kubes_google

## [0.6.6] - 2020-11-12
- dependencies version bump: kubes_aws and kubes_google

## [0.6.5] - 2020-11-12
- [#39](https://github.com/boltops-tools/kubes/pull/39) google secrets fetcher option

## [0.6.4] - 2020-11-11
- [#38](https://github.com/boltops-tools/kubes/pull/38) fix auto auth for docker login to registry, docs for secret base64, update dependencies

## [0.6.3] - 2020-11-11
- [#37](https://github.com/boltops-tools/kubes/pull/37) Dockerfile for ci and hook updates

## [0.6.2]
- [#36](https://github.com/boltops-tools/kubes/pull/36) add plugin hooks support

## [0.6.1]
- update gemspec dependency to plugins that provide the secrets helpers

## [0.6.0]
- [#35](https://github.com/boltops-tools/kubes/pull/35) mix layering support: evaluate DSL so layering can be mixed between YAML and DSL docs: https://kubes.guru/docs/layering/mix/
- custom variables support: docs https://kubes.guru/docs/variables/basic/
- custom helpers support: docs https://kubes.guru/docs/helpers/custom/
- plugins helpers support
- generators: new resource, new helper, new variable
- setup autoloader earlier. removes need for shims
- auth login for gcr also
- fix cli -h when not within Kubes project

## [0.5.1]
- fix deployment generator

## [0.5.0]
- #34 Generators, docker_image helper, check project, also write full.yaml #34
- new generators: docs: https://kubes.guru/docs/generators/
- `docker_image` helper. deprecated `built_image`. `config.image` option support.
- check_project: check within a Kubes project
- job dsl
- kubes compile: auto run docker build and push when if needed
- also write .kubes/output/full.yaml

## [0.4.7]
- #33 improve switch context: earlier and only when needed

## [0.4.6]
- #32 custom helpers support

## [0.4.5]
- #31 kubes AWS helpers

## [0.4.4]
- #30 friendly message for rendered erb yaml and dsl errors
- fix backtrace_reject pattern

## [0.4.3]
- #29 fix edge case when user provides hook on option for non-kubectl hooks

## [0.4.2]
- #28 base64 helper

## [0.4.1]
- kubes init: default namespace now includes Kubes.env
- fix kubes deploy: compile it gets called once and output folder kept
- include kubes_google dependency helpers

## [0.4.0]
- #26 features: kubes vs kubectl hooks, prune, etc
- hooks: kubes, kubectl, docker breaking changes.
- hooks now in the .kubes/config/hooks folder.
- hook for kubectl supports `on` option for more control over when to run hook.
- generalize hasher
- auto prune hashed resources like ConfigMap and Secret
- kubes prune command for manual running
- support .yml extension also
- renamed exec `--name` to `--deployment` option.
- add `--pod` option to `exec` and `logs` command.
- fix md5 hash for multiple types within envFrom
- add skip config option

## [0.3.5]
- #25 small fixes: show pod and fetch items nil

## [0.3.4]
- #24 fix namespace newline and logs for single container
- #23 init namespace option

## [0.3.3]
- #22 logs -c option. fix kubes logs for pods with multiple containers

## [0.3.2]
- #21 add namespace to logs command

## [0.3.1]
- #20 improve sidecar support. kubes exec -c option also

## [0.3.0]
- #19 new commands: exec, logs
- delete preview
- show pods as part of get

## [0.2.6]
- #18 gcloud builder. change to config.builder

## [0.2.5]
- #17 cloudbuild build strategy

## [0.2.4]
- #16 google cloudbuild support & docs: add Dockerfile for kubes as a docker entrypoint

## [0.2.3]
- #15 use kubernetes default deployment strategy instead

## [0.2.2]
- #14 init template updates, dockerfile_port helper

## [0.2.1]
- #13 improve network policy dsl

## [0.2.0]
- Initial release.

## [0.1.0]
- Placeholder
