#!/usr/bin/env coffee
fs = require 'fs'
npm = require 'npm'

write = (name)->
    npm.commands.view [name], true, (err, pkg)->
        latest = pkg[Object.keys(pkg)[0]]
        console.log latest.name


npm.load { outfd : null }, ()->
    fs.readFile 'packages.json', 'utf8', (err, content)->
        info = JSON.parse(content)
        for name, data of info
            console.log name

    #write 'd3'