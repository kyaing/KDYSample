
def test(number):

    # 函数内部再定义一个函数，并个此函数用到了外边函数的变量，那么将这个函数及用到的一些变量称为闭包；
    def test_in(number_in):
        print("in tets_in(), number_in is %d" % number_in)
        return number + number_in

    # 返回的就是闭包的结果
    return test_in

res = test(100)
print(res(200))