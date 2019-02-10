from multiprocessing import Pool, Manager
import os

""" 多线程拷贝文件 """

def copyFileTask(name, old_folder_name, new_folder_name):
    """ 拷贝一个文件 """
    fr = open(old_folder_name + '/' + name) 
    fw = open(new_folder_name + '/' + name, 'w')

    content = fr.read()
    fw.write(content)

    fr.close()
    fw.close()


def main():
    old_folder_name = input("请输入文件夹的名字：")

    # 创建新的文件夹
    new_folder_name = old_folder_name + '-复件'
    os.mkdir(new_folder_name)

    file_names = os.listdir(old_folder_name)

    # 使用多进程拷贝原文件的内容
    pool = Pool(5)
    queue = Manager().Queue()

    for name in file_names:
        pool.apply_async(copyFileTask, 
            args=(name, old_folder_name, new_folder_name, queue))

    # pool.close()
    # pool.join()

    # 记录拷贝文件的进度
    num = 0
    allNum = len(file_names)
    while num < allNum:
        queue.get() 
        num += 1
        copyRate = num / allNum
        print('\rcopy的进度是：%0.2f%%' % (copyRate * 100), end="")
    
    print('---已经完成拷贝---')

if __name__ == '__main__':
    main()
