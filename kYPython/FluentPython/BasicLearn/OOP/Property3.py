
class Test(object):
    def __init__(self):
        self.__num = 100

    @property
    def num(self):
        return self.__num

    @num.setter
    def num(self, newNum):
        self.__num = newNum

t = Test()
t.num = 200