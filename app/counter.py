class CountReocurrenceChar():
    '''Count the amount of reoccurrnce charecters in a string'''
    def __init__(self, param):
        self.param = param

    def run(self):
        '''Class entrypoint'''
        amount = [ char for char in self.param if self.param.count(char) > 1 ]
        return len(set(amount))
