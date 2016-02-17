config = {}

# thumbs config
config.photo_path = ['/my/photos/', '/my/otherphotos/']
config.photo_thumb_folder = 'cronthumbs/'
config.photo_thumb_prefix = 't_'
config.photo_thumb_gallery = 'index.html'
config.photo_extensions = ['png', 'PNG', 'jpg', 'JPG', 'jpeg', 'JPEG', 'gif', 'GIF']

# install 'imagemagick' and point to the 'convert' binary
config.convert_bin = '/usr/bin/convert'
config.convert_cmd = '-thumbnail 200x220^^ -gravity center -extent 200x200 -quality 80'

# enable nice?
config.nice_bin = '/usr/bin/nice'
config.nice_enable = true

#
#
module.exports = config
