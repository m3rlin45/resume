var fs = require('fs');
var moment = require('moment');
var validUrl = require('valid-url');
var unique = require('unique-words');
var spelling = require('spelling');
var dictionary = require('spelling/dictionaries/en_US.js');
var dict = new spelling(dictionary);

//add our additional words to dictionary
var safeWords = JSON.parse(fs.readFileSync('dictionaryAdditions.json', 'utf8'));
safeWords.AllowedWords.forEach(function (word) {
    dict.insert(word)
});

var resume = JSON.parse(fs.readFileSync('resume.json', 'utf8'));

var checkableStrings = [];


function findCheckableStrings(aResume){
    var keys = Object.keys(aResume);
    for (var i = 0; i < keys.length; i++) {
        if (typeof aResume[keys[i]] === "object") {
            findCheckableStrings(aResume[keys[i]]);
        }
        else {
            if(typeof aResume[keys[i]] === "string") 
            {
                //next get rid of all dates and urls, cant spell check those
                if (!(moment(aResume[keys[i]]).isValid()||validUrl.isUri(aResume[keys[i]]))) {
                    checkableStrings.push(aResume[keys[i]]);
                }
            }
        }
    }
}

findCheckableStrings(resume);

//convert to only unique words
var checkableWords = unique(checkableStrings);
//make a list of words that are misspelled
var mispelledWords = checkableWords.filter(function (word) {
    return !dict.lookup(word).found;
});

if (mispelledWords.length != 0) {
    console.log("Mispelled words found, either fix them or add them to dictionaryAdditions.json");
    console.log(mispelledWords);
    process.exit(1)
}
