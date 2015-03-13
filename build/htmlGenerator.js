var filePath = process.argv[2];
var nunjucks = require('nunjucks');
var fs = require('fs');
var filters = require('./filters');


var env = nunjucks.configure('templates', {
    autoescape: true
});

filters.addFilters(env);

var resume = JSON.parse(fs.readFileSync(filePath, 'utf8'));

var res = nunjucks.render('indexTemplate.html', resume);

fs.writeFileSync('index.html', res, {encoding: "utf8", flag : "w"});

process.exit(0);