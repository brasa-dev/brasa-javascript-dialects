[ -d build/ ] && rm -rf build/

mkdir build

for dialect in ./dialects/*; do
  [ ! -d $dialect ] && continue

  DIALECT=${dialect##./dialects/}
  echo $DIALECT

  jq -s 'add' $( find $dialect -name '*.json' ) > /tmp/lang.json

  jq '. | {extension: .extension, dialect: .dialect, from: "en", to: .dialect, label: .label, version: .version, identifiers: .identifiers, lexicon: (.keywords + .literals + .special) }' '/tmp/lang.json' > ./build/en_$DIALECT.json

  jq '. | {extension: .extension, dialect: "en", from: .dialect, to: "en", label: "javascript", version: .version, identifiers: .identifiers | walk(if type == "object" and has("id") then if has("identifiers") then {id: .value, value: .id, identifiers: .identifiers} else {id: .value, value: .id} end else . end), lexicon: (.keywords + .literals + .special | to_entries | map({(.value): .key}) | add) }' '/tmp/lang.json' > "build/${DIALECT}_en".json
done

