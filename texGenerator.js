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

env.addFilter('ConvertSkills', function (skills) {
    var newSkills = {};
    skills.forEach(function (skill) {
        var entry = { "level": skill.level, "keywords": skill.keywords };
        if (skill.name in newSkills) {
            newSkills[skill.name].push(entry);
        } else {
            newSkills[skill.name] = [entry];
        }
    });

    var ret = [];
    var keys = Object.keys(newSkills);
    keys.forEach(function (key) {
        ret.push({ "name": key, "entries": newSkills[key] });
    });
    return ret;
})

var resume = JSON.parse(fs.readFileSync('resume.json', 'utf8'));

var res = nunjucks.render('resumeTemplate.tex', resume);

fs.writeFileSync('resume.tex', res, {encoding: "utf8", flag : "w"});

process.exit(0);