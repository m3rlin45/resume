var moment = require('moment');
var lescape = require('escape-latex');

module.exports = {
    addFilters : function(env){
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

        env.addFilter('PrettifyDate', function (date) {
            var momentDate = moment(new Date(date));
            return momentDate.format('MMMM Do YYYY');
        })

        env.addFilter('DateYearMonth', function (date) {
            var momentDate = moment(new Date(date));
            return momentDate.format('MMMM YYYY');
        })

        env.addFilter('TeXEscape', function (str) {
            return lescape(str);
        });
    }
}

