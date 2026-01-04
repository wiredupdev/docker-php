#!/usr/bin/env bash

jq -r 'map(select(.build == true)).[]
  | .stages[] as $stage
  | "docker build  --no-cache --target \($stage) -t \(.namespace)/\(.repository):\(.tag)-\($stage|ascii_downcase) ./\(.path) "
  | split("\n") | .[]'  versions.json | while read -r image; do
    $("$image")
done

jq -r 'map(select(.build == true and .push == true)).[]
      | .stages[] as $stage
      | "docker push \(.namespace)/\(.repository):\(.tag)-\($stage|ascii_downcase)"
      | split("\n") | .[]' versions.json | while read -r image; do
    $("$image")
done
