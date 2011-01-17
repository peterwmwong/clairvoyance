less = require 'less'
{dirname} = require 'path'
{exists} = require 'path'
{readFile} = require 'fs'

module.exports = (log, file, cb) ->
   exists file, (exists) ->
      return cb 404 if not exists
      
      log "Compiling LESS #{file}"
      readFile file, (err, src) ->
         parser = new less.Parser { parser:[dirname(file)], filename:file }

         parser.parse src, (err,tree)->
            if err then cb err
            else
               try
                  cb null, tree.toCSS()
               catch err
                  cb err
