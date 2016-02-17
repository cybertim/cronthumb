# cronthumb

### what does it do?
It's a nodejs based script which can be used to generate thumbnails for folders filled with picture.
You can configure the sub-folder where the thumbs are stored and a nice index.html based on freewall.js will be put in the folder as the new index.
The script does incremental updates, it can be put into your crontab (ex. each hour) so if you auto-upload pictures to your server it will update the gallery/index accordingly.

### what is it for?
People hosting there own cloud or storage and missing a quick view of there picture library / folders.

### how do i install?
```
git clone https://github.com/cybertim/cronthumb.git
cd cronthumb
npm install
cp src/config.example.coffee src/config.coffee
```
Now edit the config.coffee and put in your own picture/photo folders.
After this you can run the script with the following commands:
```
npm run app
```
or if you have a global coffee-script install
```
coffee src/run.coffee
```
