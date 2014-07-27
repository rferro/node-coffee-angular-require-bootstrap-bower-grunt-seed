
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
session         = require('express-session')
favicon         = require('serve-favicon')

debug           = require('debug')
debugApp        = debug('app')
debugAppIo      = debug('app:io')

pkgInfo         = require('../package.json')
ms              = require('ms')

app             = express()
app.locals.app  = pkgInfo
server          = http.createServer app
io              = require('socket.io')(server)

app.set 'port',        process.env.PORT || 8000
app.set 'views',       path.join(__dirname, 'views')
app.set 'view engine', 'jade'

switch app.get('env')
  when 'development'
    app.use morgan('dev')
    app.use errorHandler()
    staticMaxAge = 0
  when 'production'
    app.use morgan('combined')
    staticMaxAge = ms('1d')

app.use '/assets', express.static(path.join(__dirname, 'public'), maxAge: staticMaxAge)
app.use favicon(path.join(__dirname, 'public/style/images/favicon.png'))

app.use responseTime()
app.use compression()

app.use bodyParser.urlencoded(extended: false)
app.use bodyParser.json()
app.use cookieParser(pkgInfo.secret)
app.use session(secret: pkgInfo.secret, resave: true, saveUninitialized: true)
app.use methodOverride()

app.get '/partials/:partial.html', (req, res) ->
  debugApp 'serve partial'
  res.render "partials/#{req.params.partial}"

app.get '*', (req, res) ->
  debugApp 'serve index'
  res.render 'index'

io.on 'connection', (socket) ->
  debugAppIo 'connect'

  socket.emit 'serverEvent', 'client connect event'

  i        = 0
  ts       = 1000
  timeouts = []

  setTimeout(
    ->
      debugAppIo 'send serverEvent'
      socket.emit 'serverEvent', 'test event ' + ++i
      timeouts[0] = setTimeout arguments.callee, ts
    0
  )

  setTimeout(
    ->
      debugAppIo 'send loadavg'
      socket.emit 'loadavg', os.loadavg()
      timeouts[1] = setTimeout arguments.callee, ts
    0
  )

  setTimeout(
    ->
      debugAppIo 'send uptime'
      socket.emit 'uptime', os.uptime()
      timeouts[2] = setTimeout arguments.callee, ts
    0
  )

  socket.on 'disconnect', ->
    debugAppIo 'disconnect'

    for to in timeouts
      clearTimeout to

server.listen app.get('port'), ->
  debugApp 'server started on port %s', app.get('port')
