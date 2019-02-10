def w1(func):
    def inner():
        print('---inner---')
        func()
    return inner

@w1 # f1 = w1(f1)
def f1():
    print('---f1---')

def f2():
    print('---f2---')

# innerFunc = w1(f1)
# innerFunc()

# f1 = w1(f1)
# f1() 

f1()