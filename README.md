# Roseta Javascript Dialects

A collection of roseta javascript dialect configurations in json.

## Why

This central repo allows to easily use dialect configurations to transpile js
into multiple localized languages and back. It also works a unique point of
truth for these translations.

## How

There is a root file defining the language keywords based on official language
definition and each dialect has an index which translates each keyword and
multiple other files for localizing libraries and other core functionalities of
each language.

### Root file

- `"keywords": [String]` : A list of JS keywords and future reserved keywords
- `"literals": [String]` : These act as keywords for roseta, but by the language definition are not keywords 
- `"special": [String]` : These are special cases and each one might be used differently. For example `arguments` only exists inside the context of function calls.

### Root identifiers

- `"identifiers": [Object]` : An object tree that uses the keys to define the structure. The special key `"___ref"` exists to avoid redeclaring identifiers and avoid reference loops.

```json
{
  "identifiers": {
    "window": {
      "window": {
        "___ref": "window",
      },
      "document" {
        "body": {}
      }
    }
  }
}
```

### Dialect root

- `"keywords": Object{[key: String]: String}` : An object defining a map for key to translation
- `"literals": Object{[key: String]: String}` : An object defining a map for key to translation
- `"special": Object{[key: String]: String}` : An object defining a map for key to translation

```json
{
  "keywords": {
    "if": "se",
    "else": "senão",
    ...
  }
}
```

### Dialect identifiers 

- `"identifiers": [Object]` : An object tree that uses the keys to define the structure. The object has 3 possible properties:


- `"___ref": String`: exists to avoid redeclaring identifiers and avoid reference loops. ("___ref" excludes all other keys)

- `"___inherits": String`: this points to other translation definition which this translation properties are inherited from
- `"___returns": String`: in case of a function this will point to the translation definition for it
- `"value": String`: the actual translation of this identifier 
- `"properties": Object`: An object tree for translation

```json
{
  "identifiers": {
    "window": {
      "value": "janela",
      "properties": {
        "document": {
          "value": "documento",
          "properties": {
            "body": {
              "value": "corpo"
            }
          }
        }
      }
    }
  }
}
```
