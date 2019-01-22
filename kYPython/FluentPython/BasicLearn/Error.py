
try:
    #print(num)
    open('xxx.txt') 
    print('----1----')
# except NameError:
#     print('NameError.') 

# except FileNotFoundError:
#     print('FileNotFoundError.')
except Exception as ret:
    print(ret)
else:
    print('--------')
finally:
    print('----finally----')

print('----2----')