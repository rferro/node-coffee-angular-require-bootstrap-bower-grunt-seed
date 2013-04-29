
express = require 'express'
http    = require 'http'
path    = require 'path'
app     = express()

app.configure ->
  app.set     'port',         process.env.PORT || 8000
  app.set     'views',        path.join(__dirname, 'views')
  app.set     'view engine',  'jade'
  app.engine  'jade',         require('jade').__express


  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static path.join(__dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/', (req, res) ->
  res.render 'index'

http.createServer(app).listen app.get('port'), -> console.log 'on port ' + app.get('port')
