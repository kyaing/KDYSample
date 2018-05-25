# coding: utf-8

class A:
    def __init__(self):
        self._internal = 0 # An internal attribute, 单下划线
        self.public = 1 # A public attribute

    def public_method(self):
        '''
        A public method
        '''
        pass

    def _internal_method(self):
        pass

class B:
    def __init__(self):
        self.__private = 0  # 双下划线

    def __private_method(self):
        pass

    def public_method(self):
        pass
        self.__private_method()

class C(B):
    def __init__(self):
        super.__init__()
        self.__private = 1  # Does not override B.__private

    # Does not override B.__private_method()
    def __private_method(self):
        pass
