#!/usr/bin/env bash

buildExpr='map(select(.build == true)).[]  | .stages[] as $stage | "docker build  --no-cache --target \($stage) -t \(.tag)-\($stage|ascii_downcase):\(.version) ./\(.path) " | split("\n")';
pushExpr='map(select(.build == true and .push == true)).[]  | .stages[] as $stage | "docker push \(.tag)-\($stage|ascii_downcase):\(.version) " | split("\n")';

jq -r "$buildExpr | .[]" versions.json | while read -r image; do
    $($image)
done

jq -r "$pushExpr | .[]" versions.json | while read -r image; do
    $($image)
done
