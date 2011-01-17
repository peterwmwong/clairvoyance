# So express can find it's own support modules
require.paths.unshift "#{__dirname}/../../support/express/support"
express = require '../../support/express'
compileCoffee = require './compile-coffee'
compileLess = require './compile-less'

log = console.log.bind console
srcdir = "#{__dirname}/../../src"


$ = express.createServer()
$.configure ->
   $.use "/", express.staticProvider(srcdir)
   $.use "/support/cell", express.staticProvider( "#{__dirname}/../../support/cell/build/")

$.get '*.css', (req,res,next)->
   compileLess log,
      "#{srcdir}/#{req.url.slice 0,-4}.less"
      (err,compiled_less)->
         if err?
            res.send "Couldn't compile LESS err=#{err}", (if err==404 then 404 else 500)
         else
            res.send compiled_less, {'Content-Type':'text/css'}, 200

$.get '*.js', (req,res,next)->
   compileCoffee log,
      "#{srcdir}/#{req.url.slice 0,-3}.coffee"
      (err,compiled_src) ->
         if err?
            res.send "Couldn't Coffee compile err=#{err}", (if err==404 then 404 else 500)
         else
            res.send compiled_src, {'Content-Type':'text/javascript'}, 200

$.listen 8080
