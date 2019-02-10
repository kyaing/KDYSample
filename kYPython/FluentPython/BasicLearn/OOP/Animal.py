class Animal:
    def eat(self):
        print('--- eat ---')

    def drink(self):
        print('--- drink ---')

    def sleep(self):
        print('--- sleep ---')

    def run(self):
        print('--- run ---')

class Dog(Animal):
    def bark(self):
        print('--- bark ---')

class Xiaotq(Dog):
    def fly(self):
        print('--- fly ---')

    def bark(self):
        print('--- Xiaotq bark ---')
        super().bark()

class Cat(Animal):
    def catch(self):
        print('--- catch ---')

huahua = Dog()
huahua.bark()

tq = Xiaotq()
tq.bark()

tom = Cat()
tom.catch()
    