import math
import random

class Heap:

    def __init__(self, lst):
        self.vals = []
        for i in lst:
            self.insert(i)

    def size(self):
        return len(self.vals)
    
    def insert(self, val):
        currentIndex = self.size()
        self.vals.append(val)
        self.swap(currentIndex)

    def swap(self, index):
        if index == 0:
            return "Done!"
        else:
            parentIndex = math.floor((index - 1) / 2)
            if self.vals[index] < self.vals[parentIndex]:
                self.vals[index], self.vals[parentIndex] = self.vals[parentIndex], self.vals[index]
                self.swap(parentIndex)
            return "Done!"

    def getMin(self):
        return self.vals[0]
    
    def extractMin(self):
        self.vals[0], self.vals[-1] = self.vals[-1], self.vals[0]
        value = self.vals.pop(self.size() - 1)
        self.moveToEnd(0)
        return value

    def moveToEnd(self, index):
        c1 = index * 2 + 1
        c2 = index * 2 + 2
        if c1 >= self.size():
            return "Done!"
        elif c2 >= self.size():
            if self.vals[index] > self.vals[c1]:
                self.vals[index], self.vals[c1] = self.vals[c1], self.vals[index]
            return "Done!"
        else:
            if self.vals[c1] <= self.vals[c2]:
                minIndex = c1
            else:
                minIndex = c2

            if self.vals[index] > self.vals[minIndex]:
                self.vals[index], self.vals[minIndex] = self.vals[minIndex], self.vals[index]
            return self.moveToEnd(minIndex)                  

def main():
##    a = Heap([50])
##    for i in range(0, 49):
##        a.insert(random.randint(0, 100))
##    print(a.vals)
##    for i in range(0, 50):
##        print(a.extractMin())
##
##    b = []
##    for i in range(0, 30):
##        b.append(random.randint(0, 100))
##    print(b)
##    b = Heap(b)
##    print(b.vals)

    c = []
    c = Heap(c)
    print(c.vals)
    c.insert(3)
    print(c.vals)
    c.insert(5)
    print(c.vals)
    c.insert(4)
    print(c.vals)
    c.insert(2)
    print(c.vals)
    c.insert(1)
    print(c.vals)

if __name__ == "__main__":
    main()
