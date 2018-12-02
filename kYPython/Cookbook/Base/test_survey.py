from survey import AnonymousSurvey
import unittest

class TestAnonymousSurvey(unittest.TestCase):
    def test_store_single_response(self):
        question = "What Language did you first learn to speak?"
        my_survey = AnonymousSurvey(question)
        my_survey.store_response('English')
        self.assertIn("English", my_survey.response)

unittest.main()