# Changelog

All notable changes to this project will be documented in this file.
This project *loosely tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

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
