import Sys 

class Test(object):
    def __init__(self, switch):
        self.switch = switch
    
    def cal(self, a, b):
        try:
            return a / b
        except Exception as ret:
            if self.switch:
                print('get error: ')
                print(ret)
        else:
            # 重新再抛出异常
            raise

a = Test(True)
a.cal(11, 0)
print('--------------------')

a.switch = False
a.cal(11, 0)