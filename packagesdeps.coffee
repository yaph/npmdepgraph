#!/usr/bin/env coffee
fs = require 'fs'
npm = require 'npm'

props = ['name', 'description', 'maintainers', 'author', 'version', 'keywords', 'homepage', 'contributors', 'dependencies']
deps = []
cache = {}

write = (name, firstletter)->
    npm.commands.view [name], true, (err, pkg)->
        latest = pkg[Object.keys(pkg)[0]]
        return if typeof latest is 'undefined'
        pkgobj = {}
        props.map (prop)->
            if latest.hasOwnProperty prop
                pkgobj[prop] = latest[prop]

        # package dependencies
        adjlist = [pkgobj.name]
        if typeof pkgobj.dependencies is 'object'
            pkgdeps = Object.keys(pkgobj.dependencies)
            adjlist = adjlist.concat pkgdeps if pkgdeps.length
        deps.push adjlist.join ';'

        cache[firstletter][name] = pkgobj
        fs.writeFile 'packages/' + firstletter + '.json', JSON.stringify(cache[firstletter]), (err)->
            console.log err if err

        fs.writeFile 'packagesdeps.csv', deps.join('\n'), (err)->
            console.log err if err


procpkgs = (pkgs)->
    for name, data of pkgs
        firstletter = name.charAt 0
        if !(cache.hasOwnProperty firstletter)
            cache[firstletter] = {}
        write name, firstletter


#npm.load { outfd : null }, ()->
    #fs.readFile 'packages.json', 'utf8', (err, content)->
        #procpkgs JSON.parse(content)

testpkgs = {
    'd3': {name: 'd3'},
    'd3-browser': {name: 'd3-browser'},
    'zzz': {name: 'zzz'}
}
npm.load { outfd : null }, ()->
    procpkgs testpkgs