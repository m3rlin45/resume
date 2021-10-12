import os
import string
import json
import re
from email.utils import parseaddr
from spellchecker import SpellChecker

spell = SpellChecker()
ROOT_PATH = os.path.join(os.path.dirname(__file__),"../")
number_checker = re.compile(r"[\d]+")

def test_spelling():
    
    with open(os.path.join(ROOT_PATH,"resume.json")) as resume_json:
        resume = json.load(resume_json)

    with open(os.path.join(ROOT_PATH, "dictionaryAdditions.json")) as custom_words:
        spell.word_frequency.load_words(json.load(custom_words)["AllowedWords"])
    

    def check_spelling(obj):
        if not obj:
            return
        if isinstance(obj, str):
            # tokenize
            for piece in obj.split(" "):
                # ignore email addresses
                if parseaddr(piece)[1]:
                    continue
                # strip punctuation and lowercase
                normalized = piece.lower().translate(str.maketrans("", "", string.punctuation))
                if number_checker.match(normalized):
                    continue
                assert spell[normalized], f"spelling error: {piece}"
        elif isinstance(obj, list):
            [check_spelling(child) for child in obj]
        else:
            assert isinstance(obj, dict)
            [check_spelling(child) for child in obj.values()]

    check_spelling(resume)
        
    
