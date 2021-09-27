# Prerequisite to dev

## Tools
 - yarn
   
## Environment configuration variable
 - PATH with `./node_modules/.bin`


# Common tasks

## Exposed module

Run `yarn elm-exposed-module` and edit `elm.json` the needed entry

#publish
             
- git tag x.x.x

- elm diff

- elm bump

- git push --tags origin master

- elm publish