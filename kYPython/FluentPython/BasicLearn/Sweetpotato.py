
class SweetPotato:
    def __init__(self):
        self.cookedString = "1"
        self.cookedLevel = 0
        self.condiments = []

    # def __str__(self):
    #     return "state：%s (%d)" % (self.cookedString, self.cookedLevel)
    
    def cook(self, cooked_time):
        self.cookedLevel += cooked_time

        if cooked_time >=0 and cooked_time < 3:
            self.cookedString = "1"
        elif cooked_time >= 3 and cooked_time < 5:
            self.cookedString = "2"
        elif cooked_time > 5 and cooked_time < 8:
            self.cookedString = "0"
        else:
            self.cookedString = "3"

    def addCondiments(self, item):
        self.condiments.append(item)

di_gua = SweetPotato()
print(di_gua)

di_gua.cook(1)
print(di_gua)  