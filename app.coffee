highlight   = require 'highlight.js'
html2text   = require 'html-to-text'
express     = require 'express'
request     = require 'request'
marked      = require 'marked'
async       = require 'async'
less        = require 'less-middleware'
http        = require 'http'
path        = require 'path'
Poet        = require 'poet'

{Renderer}  = marked

String::startsWith    ?= (str) -> 0 is @indexOf str
String::startsWithAny  = (lst) -> return true for str in lst when @startsWith str; false

(app = express()).configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

  app.set 'github name',        'chester1000'
  app.set 'github repo url',    'https://api.github.com/repos/%s'
  app.set 'github readme url',  'https://raw.github.com/%s/master/README.md'

  app.set 'youtube embed url',  '<iframe width="853" height="480" src="//www.youtube.com/embed/%s" frameborder="0" allowfullscreen></iframe>'
  app.set 'youtube url regex',  /^.*(?:youtu.be\/|v\/|e\/|u\/\w+\/|embed\/|v=)([^#\&\?]*).*/

  app.use (req, res, next) ->
    if req.path.startsWithAny ['/post', '/stylesheets', '/bootstrap', '/images', '/github', '/javascripts']
      res.header 'Cache-Control', 'max-age=300'
    next()

  app.use (req, res, next) ->
    unless req.is 'text/*' then next()
    else
      req.text = ''
      req.setEncoding 'utf8'
      req.on 'data', (chunk) -> req.text += chunk
      req.on 'end', next

  app.use express.favicon path.join process.cwd(), 'public/favicon.ico'
  app.use express.logger 'dev'
  app.use less path.join __dirname, '/public'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static path.join(__dirname, 'public'), maxAge:300


app.get '/post-content/*', (req, res) ->
  res.header 'Cache-Control', 'max-age=300'
  res.sendfile path.join __dirname, '_posts', req.params[0]

app.configure 'development', ->
  app.use express.errorHandler()

renderer = new Renderer()

renderer.image = (href, title, text) ->
  yt = href.match app.get 'youtube url regex'

  "<center>" + (

    if yt? then app.get('youtube embed url').replace /%s/g, yt[1]
    else 
      href = "/post-content/" + href unless href.startsWith "http"
      new Renderer().image href, title, text

  ) + "</center>"

marked.setOptions
  renderer: renderer
  gfm: true
  sanitize: true
  smartypants: true
  highlight: (code) -> highlight.highlightAuto(code).value

poet = Poet app, 
  posts: './_posts'
  postsPerPage: 3

.addTemplate
  ext: ['markdown', 'md']
  fn: marked

poet.init ->

  app.get '/rss', (req, res) ->
    posts = poet.helpers.getPosts 0, 5

    posts.forEach (post) ->
      post.rssDescription = html2text.fromString post.preview

    res.render 'rss', posts: posts

  attachGithubRepo = (repoName) ->
    fullRepoName = app.get("github name") + "/" + repoName
    getGithub = (type, callback) ->
      request
        headers: 'User-Agent': 'node.js'
        url: app.get('github ' + type + ' url').replace /%s/g, fullRepoName
      , callback

    app.get '/' + repoName.replace(/-/g, ""), (req, res) ->
      res.header 'Cache-Control', 'max-age=300'

      async.parallel [
        (cb) -> getGithub 'repo',   (err, resp, body) -> cb null, JSON.parse body
        (cb) -> getGithub 'readme', (err, resp, body) -> marked body, cb

      ], (err, results) ->
        return res.send err if err?

        info = results[0]

        res.render 'github',
          name: fullRepoName
          markdown: results[1]
          project:
            owner: info.owner
            title: info.name
            description: info.description

  app.get '/', (req, res) -> res.render 'index', posts: poet.helpers.getPosts 0, 3

  attachGithubRepo "Pretty-Binary-Clock"
  attachGithubRepo "BitcoinMonitor"

  http.createServer app
    .listen app.get('port'), ->
      console.log "Express server listening on port " + app.get 'port'

