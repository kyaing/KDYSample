import json 

def greet_user():
    ''' 问候客户，并指出其名字 '''
    filename = 'username.json'

    try:
        with open(filename) as f_obj:
            username = json.load(f_obj)
    except FileNotFoundError:
        username = input("What is yopur name?")
        with open(filename, 'w') as f_obj:
            json.dump(username, f_obj)
            print("we'll remeber you when you com back, " + username + "!")
    else:
        print("Welcome back, " + username + "!")

greet_user()