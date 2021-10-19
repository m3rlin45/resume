import os
import string
import json
import re
import unittest
import validators
from spellchecker import SpellChecker

spell = SpellChecker()
ROOT_PATH = os.path.join(os.path.dirname(__file__),"../")
USER_DICT_PATH = os.path.join(ROOT_PATH, "dictionaryAdditions.json")
number_checker = re.compile(r"[\d]+")


def normalize(word):
    return word.lower().translate(str.maketrans("", "", string.punctuation))

def get_allowed_words():
    with open(USER_DICT_PATH) as custom_words:
        return json.load(custom_words)["AllowedWords"]
    

class TestSpelling(unittest.TestCase):

    def test_user_dict_sorted(self):
        self.assertListEqual(get_allowed_words(), sorted(get_allowed_words()))
        

    def test_spelling(self):
    
        with open(os.path.join(ROOT_PATH,"resume.json")) as resume_json:
            resume = json.load(resume_json)

        spell.word_frequency.load_words([normalize(word) for word in get_allowed_words()])
        
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
    
