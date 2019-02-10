from threading import Thread
import time

class MyThread(Thread):
    def run(self):    # 与 Process相似，重写run()方法
        for i in range(3):
            time.sleep(1)
            msg = "I'm " + self.name + ' @ ' + str(i)
            print(msg)

def test():
    for i in range(5):
        t = MyThread()
        t.start()

if __name__ == '__main__':
    test()