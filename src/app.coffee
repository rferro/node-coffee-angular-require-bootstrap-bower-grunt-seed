
debug           = require('debug')('app')

http            = require('http')
path            = require('path')
os              = require('os')

express         = require('express')
bodyParser      = require('body-parser')
compression     = require('compression')
cookieParser    = require('cookie-parser')
methodOverride  = require('method-override')
errorHandler    = require('errorhandler')
morgan          = require('morgan')
responseTime    = require('response-time')

app             = express()
app.locals.app  = require('../package.json')
server          = http.createServer app
io              = require('socket.io')(server)

app.set 'port',         process.env.PORT || 8000
app.set 'views',        path.join(__dirname, 'views')
app.set 'view engine',  'jade'

switch app.get('env')
  when 'development'
    app.use errorHandler()
    app.use morgan('dev')
  when 'production'
    app.use morgan('combined')

app.use express.static path.join(__dirname, 'public')
app.use bodyParser.urlencoded(extended: false)
app.use bodyParser.json()
app.use compression()
app.use cookieParser('HASH')
app.use methodOverride()
app.use responseTime()

app.get '/partials/:partial.html', (req, res) ->
  res.render "partials/#{req.params.partial}"

app.get '*', (req, res) ->
  res.render 'index'

io.on 'connection', (socket) ->
  socket.emit 'serverEvent', 'client connect event'

  i = 0

  timeouts = []

  setTimeout(
    ->
      socket.emit 'serverEvent', 'test event ' + ++i
      timeouts[0] = setTimeout arguments.callee, 1000
    0
  )

  setTimeout(
    ->
      socket.emit 'loadavg', os.loadavg()
      timeouts[1] = setTimeout arguments.callee, 2000
    0
  )

  setTimeout(
    ->
      socket.emit 'uptime', os.uptime()
      timeouts[2] = setTimeout arguments.callee, 1000
    0
  )

  socket.on 'disconnect', ->
    for to in timeouts
      clearTimeout to

server.listen app.get('port'), ->
  debug 'on port %s', app.get('port')
