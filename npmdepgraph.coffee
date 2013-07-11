# create adjacency csv from npm package dependencies for use in gephi
npm = require('npm')
npm.load()

npmdep = require('npmdep')

npmdep.load (err, pkgs) ->
    for pkg, data of pkgs
        console.log npm.info
        adjlist = []
        adjlist.push pkg
        if typeof data.dependencies is 'object'
            deps = Object.keys(data.dependencies)
            adjlist = adjlist.concat deps if deps.length

        console.log adjlist.join ';'