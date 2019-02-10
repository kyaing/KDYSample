def makeBold(func):
    def wrapped():
        return "<b>" + func() + "</b>"
    return wrapped

def makeItalic(func):
    def wrapped():
        return "<i>" + func() + "</i>"
    return wrapped

@makeBold
@makeItalic
def test():
    return "hello world"

res = test()
print(res)