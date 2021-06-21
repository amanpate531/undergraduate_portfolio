filterArray = [0]*13

def h(string, size):
    sum = 0 
    for letter in string:
        sum = sum + ord(letter)
    return sum % size
print(h("Arsenal",len(filterArray)))

def h2(string, size):
    sum = 0
    count = 0
    for letter in string:
        count = count + 1
        sum = sum + 2 * count + ord(letter)
    return sum % size

print(h2("Arsenal", len(filterArray)))

def h3(string, size):
    sum = 0
    count = 0
    for letter in string:
        count += 3
        sum = sum + 7 * count + ord(letter)
    return sum % size

print(h3("Arsenal", len(filterArray)))

def insertName(name):
    val1 = h(name, len(filterArray))
    val2 = h2(name, len(filterArray))
    val3 = h3(name, len(filterArray))
    filterArray[val1] = 1
    filterArray[val2] = 1
    filterArray[val3] = 1

print("Before:", filterArray)
insertName("Arsenal")
print("After:", filterArray)


def conversion(name, size):
    return (h(name, size), h2(name, size), h3(name, size))

print(conversion("Arsenal", 13))

def find(name):
    tup = conversion(name, len(filterArray))
    for i in range(0, 3):
        if filterArray[tup[i]] != 1:
            return False
    return True

print(find("Arsenal"))
