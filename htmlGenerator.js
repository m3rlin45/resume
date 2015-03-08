var nunjucks = require('nunjucks');
var fs = require('fs');


var env = nunjucks.configure('templates', {
    autoescape: true
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

var res = nunjucks.render('indexTemplate.html', resume);

fs.writeFileSync('index.html', res, {encoding: "utf8", flag : "w"});

process.exit(0);