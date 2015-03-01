var fs = require('fs');
var resume = JSON.parse(fs.readFileSync('resume.json', 'utf8'));
resume.forEach(function (resumeObj) {
    console.log(resumeObj);
});