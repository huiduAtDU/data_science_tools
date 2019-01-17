def apply_fn(high, fn = lambda x:x):
    '''
    create squrare
    '''
    return [f(i) for i in range(high)]

print(apply_fn(10, lambda x: x**10))
