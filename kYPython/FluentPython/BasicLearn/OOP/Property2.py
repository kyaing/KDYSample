
class Test(object):
    def __init__(self):
        self.__num = 100

    def getNum(self):
        return self.__num
        
    def setNum(self, newNum):
        self.__num = newNum

    # 定义属性
    num = property(getNum, setNum)

t = Test()
# t.__num = 200  # 这里相当于给 t 定义了属性恰巧叫 __num
# print(t.__num)

print(t.getNum())
t.setNum(50)
print(t.getNum())

t.num = 200
print(t.num)