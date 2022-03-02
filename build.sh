[ -d build/ ] && rm -rf build/

mkdir build

for dialect in ./dialects/*; do
  [ ! -d $dialect ] && continue

  DIALECT=${dialect##./dialects/}
  echo $DIALECT

  jq '. | {from: "en", to: .dialect, label: .label, version: .version, lexicon: (.keywords + .literals + .special) }' "$dialect/root.json" > ./build/to_$DIALECT.json
  jq '. | {from: .dialect, to: "en", label: "javascript", version: .version, lexicon: (.keywords + .literals + .special | to_entries | map({(.value): .key}) | add) }' "$dialect/root.json" > build/from_$DIALECT.json
done

