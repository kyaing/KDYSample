""" 模拟4S店售车 """

class CarStore(object):
    def __init__(self):
        self.factory = SelectCarFactory()  

    def order(self, car_type): 
        return self.factory.select_car_by_type(car_type)

# 简单工厂模式 
class SelectCarFactory(object):
    def select_car_by_type(car_type):
        if car_type == 'gti':
            return GTI()
        elif car_type == 'polo':
            return Polo()       

class Car(object):
    def move(self):
        print('Car is moving.')

    def music(self):
        print('Car is playing music.')

    def stop(self):
        print('Car is stop.')

class GTI(Car):
    pass

class Polo(Car):
    pass

car_store = CarStore()
car = car_store.order('gti')

car.move()
car.music()
car.stop()