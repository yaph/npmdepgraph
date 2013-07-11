# create adjacency csv from npm package dependencies for use in gephi
npmdep = require('npmdep')

npmdep.load (err, pkgs) ->
    for pkg, data of pkgs
        adjlist = []
        adjlist.push pkg
        if typeof data.dependencies is 'object'
            deps = Object.keys(data.dependencies)
            adjlist = adjlist.concat deps if deps.length

        console.log adjlist.join ';'