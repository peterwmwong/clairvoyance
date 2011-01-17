coffee = require 'coffee-script'
{exists} = require 'path'
{readFile} = require 'fs'

module.exports = (log, file, cb) ->
   exists file, (exists) ->
      return cb 404 if not exists
      
      log "Compiling Coffee #{file}"
      readFile file, (err, src) ->
         if err then cb err
         else
            try cb null, coffee.compile src.toString()
            catch err
               log "!!! FAILED to compiling Coffee #{file}, err=#{inspect err2}"
               cb err

