express = require('express')
routes = require('./routes')
user = require('./routes/user')
http = require('http')
path = require('path')

app = express()

app.configure ->
  publicDir = "#{__dirname}/public"
  viewsDir  = "#{__dirname}/views"

  app.set "port", process.env.PORT || 3000
  app.set "views", viewsDir
  app.set "view engine", "ejs"
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('pix_js_secret')
  app.use express.session()
  app.use app.router
  app.use express.static(publicDir)

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/user", user.list

http.createServer(app).listen(app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
)
