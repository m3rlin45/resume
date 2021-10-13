import os
import string
import json
import re
import validators
from spellchecker import SpellChecker

spell = SpellChecker()
ROOT_PATH = os.path.join(os.path.dirname(__file__),"../")
number_checker = re.compile(r"[\d]+")

def normalize(word):
    return word.lower().translate(str.maketrans("", "", string.punctuation))

def test_spelling():
    
    with open(os.path.join(ROOT_PATH,"resume.json")) as resume_json:
        resume = json.load(resume_json)

    with open(os.path.join(ROOT_PATH, "dictionaryAdditions.json")) as custom_words:
        spell.word_frequency.load_words([normalize(word) for word in json.load(custom_words)["AllowedWords"]])
    

    def check_spelling(obj):
        if not obj:
            return
        if isinstance(obj, str):
            # tokenize
            for piece in obj.split(" "):
                # ignore email addresses and urls
                if validators.email(piece) or validators.url(piece):
                    continue
                # strip punctuation and lowercase
                normalized = normalize(piece)
                if number_checker.match(normalized):
                    continue
                assert spell[normalized], f"spelling error: {piece}: normalized as {normalized}"
        elif isinstance(obj, list):
            [check_spelling(child) for child in obj]
        else:
            assert isinstance(obj, dict)
            [check_spelling(child) for child in obj.values()]

    check_spelling(resume)
        
    
