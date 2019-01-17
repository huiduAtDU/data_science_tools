def square(high, n):
    '''
    create squrare
    '''
    return [i**n for i in range(high)]

print(list(square(10,2)))
