var nunjucks = require('nunjucks');
var fs = require('fs');
var lescape = require('escape-latex');


var env = nunjucks.configure('templates', {
    tags: {
        blockStart: '<%',
        blockEnd: '%>',
        variableStart: '<$',
        variableEnd: '$>',
        commentStart: '<#',
        commentEnd: '#>'
    }
});

env.addFilter('TeXEscape', function(str) {
    return lescape(str);
});

var resume = JSON.parse(fs.readFileSync('resume.json', 'utf8'));

var res = nunjucks.render('resumeTemplate.tex', resume);

fs.writeFileSync('resume.tex', res, {encoding: "utf8", flag : "w"});

process.exit(0);