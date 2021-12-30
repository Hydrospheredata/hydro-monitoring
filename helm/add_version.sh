#!/usr/bin/env bash

DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat >> index.yaml << EOM
  - apiVersion: v2
    created: ${DATE}
    description: Hydro-monitoring is a cluster for monitoring your machine learning models in production
    digest: ${2}
    name: monitoring
    urls:
    - https://github.com/Hydrospheredata/hydro-monitoring/releases/download/${1}/monitoring-${1}.tgz
    version: ${1}
    appVersion: ${1}
EOM
