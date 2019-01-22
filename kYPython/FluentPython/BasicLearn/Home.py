import io
import sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf8')

class Home:
    def __init__(self, new_area, new_info, new_addr):
         self.area = new_area
         self.info = new_info
         self.addr = new_addr
         self.left_area = new_area
         self.contain_items = []

    def __str__(self):
        msg = "房子的面积是：%d，房子的可用面积是：%d，户型是：%s，地址是：%s;" % \
         (self.area, self.left_area,self.info, self.addr)
        msg += " 当前房子里的物品有%s" % (str(self.contain_items))
        return msg

    def add_item(self, item):
        self.left_area -= item.get_area()
        self.contain_items.append(item.get_name())

class Bed:
    def __init__(self, new_name, new_area):
        self.name = new_name
        self.area = new_area

    def __str__(self):
        return "%s占用的面积 %d" % (self.name, self.area)

    # 利用方法来获取属性，从而达到保护对象的属性 
    def get_area(self):
        return self.area

    def get_name(self):
        return self.name
        
house = Home(120, '三室', '北京')
print(house)

bed1 = Bed("西蒙", 4)
print(bed1)

house.add_item(bed1)
print(house)

bed2 = Bed("三人床", 6)
print(bed2)

house.add_item(bed2)
print(house)



