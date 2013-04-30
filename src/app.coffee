
express = require 'express'
http    = require 'http'
path    = require 'path'

app     = express()
server  = http.createServer app
io      = require('socket.io').listen(server)

io.configure 'production', () ->
  io.set 'log level', 1

io.configure 'development', () ->
  io.set 'log level', 3

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

io.sockets.on 'connection', (socket) ->
  socket.emit 'serverEvent', 'client connect event'

  setTimeout(
    ->
      socket.emit 'serverEvent', 'test event'
      setTimeout arguments.callee, 2000
    2000
  )

app.get '/', (req, res) ->
  res.render 'index'

server.listen app.get('port'), -> console.log 'on port ' + app.get('port')
