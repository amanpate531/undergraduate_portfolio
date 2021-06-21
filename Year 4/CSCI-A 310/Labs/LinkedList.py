# Aman Patel
# CSCI-A 310
# January 31, 2021

class Empty:

    def __init__(self):
        pass
    def cons(self, item):
        return LinkedList(item)
    def length(self):
        return 0
    def isEmpty(self):
        return True
    def append(self, lst):
        return lst
    def __str__(self):
        return "Empty"

class LinkedList:

    def __init__(self, elem):

        self.first = elem
        self.rest = Empty()

    def get_rest(self):
        return self.rest

    def get_first(self):
        return self.first

    def cons(self, item):
        a = LinkedList(item)
        a.rest = self
        return a

    def length(self):
        return self.rest.length() + 1

    def append(self, lst):
        if lst.isEmpty():
            return self
        else:
            a = self.get_rest().append(lst)
            return a.cons(self.get_first())

    def isEmpty(self):
        return False

    def __str__(self):
        return str(self.first) + " " + str(self.rest)

def main():
  a = Empty()
  print( "Empty list: " + str(a) )
  print( "Is the list empty at this stage? Answer: " + str(a.isEmpty()) )
  print( "How long is the list at this stage? Answer: " + str(a.length()) )
  a = a.cons(3)
  print( "Adding 3 list becomes: " + str(a) )
  print( "Is the list empty at this stage? Answer: " + str(a.isEmpty()) )
  a = a.cons(5)
  print( "Adding 5 list becomes: " + str(a) )
  a = a.cons(1)
  print( "Adding 1 list becomes: " + str(a) )
  print( "How long is the list at this stage? Answer: " + str(a.length()) )
  a = a.get_rest().get_rest().cons(1)
  print( "Taking out the 5 the list becomes: " + str(a) )
  print( "Is the list empty at this stage? Answer: " + str(a.isEmpty()) )
  b = Empty()
  b = b.cons(9)
  c = a.append(b)
  print( str(a) + " append " + str(b) + " produces " + str(c) )

if __name__=="__main__":
  main()
