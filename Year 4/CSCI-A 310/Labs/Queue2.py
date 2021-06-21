# Aman Patel
# CSCI-A 310
# January 31, 2021

from LinkedList import *

class Queue:
  def __init__(self): # constructor
    self.contents = Empty()
  def isEmpty(self): # predicate to test contents 
    return self.contents.isEmpty()
  def front(self): # lookup function 
    return self.contents.get_first()
  def enqueue(self, element): # add elements 
    self.contents = self.contents.append(LinkedList(element))
  def dequeue(self): # take elements out 
    item = self.front()
    self.contents = self.contents.get_rest()
    return item
  def __str__(self): # functions to simplify viewing 
    return str(self.contents)
  def __repr__(self):
    return str(self.contents)

def main():
  a = Queue()            # creates an empty queue 
  print(str(a) + " is the empty queue")               # prints [] 
  print(str(a.isEmpty()) + " should print True")     # prints True 
  a.enqueue(1)           # prints nothing but adds 1 to the queue 
  print(str(a) + " if we add 1 to the queue")               # prints [1]
  print(str(a.front()) + " prints 1 since that's the front")       # prints 1
  print(str(a) + " is a queue with one element")               # prints [1]
  a.enqueue(5)           # prints nothing the queue is now [1, 5]
  a.enqueue(8)           # prints nothing the queue is now [1, 5, 8]
  a.enqueue(10)          # prints nothing the queue is now [1, 5, 8, 10]
  print(str(a.isEmpty()) + " since the queue is not empty")     # prints False  
  print(str(a) + " is [1, 5, 8, 10]")               # prints [1, 5, 8, 10]
  print(str(a.dequeue()) + " is 1") # prints 1 and the queue is now [5, 8, 10]
  print(str(a)+ " is [5, 8, 10]")               # prints [5, 8, 10]

if __name__=="__main__":
  main()
