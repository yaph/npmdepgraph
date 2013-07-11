#!/usr/bin/env coffee
# load basic info on all npm packages and save in json file
fs = require 'fs'
npm = require 'npm'

npm.load { outfd : null }, ()->
    npm.commands.search (err, pkgs) ->
        fs.writeFile 'packages.json', JSON.stringify(pkgs), (err)->
            console.log err if err