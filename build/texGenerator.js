var filePath = process.argv[2];
var nunjucks = require('nunjucks');
var fs = require('fs');
var filters = require('./filters');


var env = nunjucks.configure('templates', {
    autoescape: false,
    tags: {
        blockStart: '<%',
        blockEnd: '%>',
        variableStart: '<$',
        variableEnd: '$>',
        commentStart: '<#',
        commentEnd: '#>'
    }
});

filters.addFilters(env);

var resume = JSON.parse(fs.readFileSync(filePath, 'utf8'));

var res = nunjucks.render('resumeTemplate.tex', resume);

fs.writeFileSync('resume.tex', res, {encoding: "utf8", flag : "w"});

process.exit(0);