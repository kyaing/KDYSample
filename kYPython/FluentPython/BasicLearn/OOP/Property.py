
class Tool(object):
    # 类属性
    num = 0

    # 实例方法
    def __init__(self, new_name):
        # 操作类属性
        # Tool.num += 1
        # 实例属性
        self.name = new_name

    # 类方法
    @classmethod
    def add_num(cls):
        cls.num = 10

    # 静态方法
    @staticmethod
    def print_menu():
        print('================')

tool1 = Tool('tool1')
tool2 = Tool('tool2')
tool3 = Tool('tool3')

print(Tool.num)

# Tool.add_num()
tool1.add_num()  # 也可以用实例对象来调用类方法
print(Tool.num)

tool1.print_menu()
# Tool.print_menu()