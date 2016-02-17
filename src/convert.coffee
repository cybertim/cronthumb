config = require './config.coffee'
fs = require 'fs'
execSync = require 'child_process'
  .execSync

# search through photo paths for new stuff
update = ->
  for path in config.photo_path
    if path.endsWith('/')
      process path
    else
      console.log '!! not a valid path (maybe add / ?) "' + path + '"'

process = (path) ->
  counter = 0
  flist = fs.readdirSync path
  for f in flist
    if not f.startsWith(config.photo_thumb_folder.substring(0, config.photo_thumb_folder.length - 1))
      try
        stat = fs.statSync path + f
        if stat? and stat.isDirectory()
          # recursive search in new path for images
          process path + f + '/'
        else
          if f.indexOf('.') isnt -1
            ext = f.split '.'
            if ext[ext.length - 1] in config.photo_extensions
              #crud_thumb path + f
              convert path, f
              counter++
      catch err
        console.log err
  # write the gallery html
  if counter isnt 0
    page path
  #else
  #  fs.rmdirSync path + config.photo_thumb_folder


# convert a thumb entry
convert = (path, filename) ->
  thumbfile = path + config.photo_thumb_folder + config.photo_thumb_prefix + filename
  try
    stat = fs.statSync thumbfile
  catch error
    cmd = config.convert_bin + ' ' + config.convert_cmd + ' "' + path + filename + '" "' + thumbfile  + '"'
    if config.nice_enable
      cmd = config.nice_bin + ' ' + cmd
    out = execSync cmd

orig = (z) ->
  z.substring(config.photo_thumb_prefix.length)

page = (path) ->
  thumbpath = path + config.photo_thumb_folder
  try
    stat = fs.statSync thumbpath
  catch err
    fs.mkdirSync thumbpath
    console.log 'created ' + config.photo_thumb_folder + ' folder @ ' + path
  html = "<html><head>"
  html += "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js\"></script>"
  html += "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/freewall/1.0.5/freewall.min.js\"></script>"
  html += "<style type=\"text/css\">"
  html += ".cell { background-position: center center; background-repeat: no-repeat; background-size: cover; position: absolute;}"
  html += "</style>"
  html += "</head><body>"
  html += "<div id=\"freewall\" style=\"margin: 8px;\">"
  flist = fs.readdirSync thumbpath
  flist.sort (a, b) ->
    fs.statSync(path + orig(b)).mtime.getTime() - fs.statSync(path + orig(a)).mtime.getTime()
  for f in flist
    ext = f.split '.'
    if ext[ext.length - 1] in config.photo_extensions
      html += "<a href='" + orig(f) + "'>"
      html += "<div class='cell' style='width: 200px; height: 200px; background-image: url(\"" + config.photo_thumb_folder + f + "\");'>"
      html += "</div></a>"
  html += "</div><script type=\"text/javascript\">"
  html += "var wall = new Freewall('#freewall');"
  html += "wall.reset({ selector: '.cell', animate: true, cellW: 20, cellH: 200, onResize: function() { wall.fitWidth(); } });"
  html += ""
  html += "wall.fitWidth();"
  html += "$(window).trigger('resize');"
  html += "</script></body></html>"
  fs.writeFileSync path + config.photo_thumb_gallery, html
  console.log config.photo_thumb_gallery + ' written @ ' + path

module.exports = {
  run: update
}
