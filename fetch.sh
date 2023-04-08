#!/usr/bin/env bash
# Downloads all docker mod scripts

MODS=$(curl https://theme-park.dev/themes.json | jq -r '.["docker-mods"]')
if [[ "$0" == "bash" ]]; then
    DIR="/tmp/theme-park-mods"
else
  DIR="$0"
fi
mkdir -p "$DIR"
printf "\nSaving mods into $DIR\n\n"
jq -r 'to_entries | map(.key + "|" + (.value | tostring)) | .[]' <<< "$MODS" | \
  while IFS='|' read key value; do
    curl "$value" --create-dirs --output "$DIR/98-themepark-$key" --silent
    echo "Fetched $key script"
  done
chmod -R +x $DIR