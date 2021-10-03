# Prerequisite to dev

## Tools
 - yarn
   
# Common tasks

## Check before publishing

### Doc
Run `yarn elm-doc-preview` to check if the doc could be generated otherwise the `elm publish` will fail

See more : https://www.npmjs.com/package/elm-doc-preview

### Code

`yarn elm-review`

See more https://github.com/jfmengels/elm-review

## Exposed module

Run `yarn elm-exposed-module` and edit `elm.json` the needed entry

#publish
             
- elm diff
- elm bump
- git commit
- git tag x.x.x
- git push --tags origin master
- elm publish