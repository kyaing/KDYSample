import unittest
from names_function import get_formated_name

class NamesTestCase(unittest.TestCase):
    '''测试names_function.py'''

    def test_first_last_name(self):
        formatted_name = get_formated_name('janis', 'joplin')
        self.assertEqual(formatted_name, 'Janis Joplin')
    
    def test_first_middle_last_name(self):
        formatted_name = get_formated_name('wolfgang', 'mozart', 'amadeus')
        self.assertEqual(formatted_name, 'Wolfgang Amadeus Mozart')

unittest.main()

