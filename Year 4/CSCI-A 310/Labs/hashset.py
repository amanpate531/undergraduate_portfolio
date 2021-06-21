class HashSet:
  def __init__(self, lon):
    self.lon = lon
  def __len__(self): # see page 10 
    return len(self.lon)
  def intersection_update(self, other): # see page 144
    a = []
    for e in self.lon:
      if e in other.lon:
        a += [ e ]
    self.lon = a
  def update(self, other): # see page 144
    for e in other.lon:
      if e in self.lon:
        pass
      else:
        self.lon += [ e ]
  def clear(self): # see page 144
    self.lon = []
  def difference_update(self, other): # see page 144
    a = []
    for e in self.lon:
      if e in other.lon:
        pass
      else:
        a += [ e ]
  def __iter__(self): # see page 10
    for e in self.lon:
      yield e # see also page 23
  def difference(self, other): # see page 143
    a = []
    for e in self.lon:
      if e in other.lon:
        pass
      else:
        a += [ e ]
    return HashSet(a)
  def issubset(self, other): # see page 143 
    a = True
    for e in self.lon:
      a = a and e in other
    return a
  def issuperset(self, other): # see page 143
    return other.issubset(self)
  def copy(self): # see page 143
    return HashSet(self.lon)
  def add(self, element): # see table page 144 in the middle
    if element in self.lon:
      pass
    else:
      self.lon += [ element ]
  def discard(self, element): # see page 143
    self.lon.remove(element)
  def remove(self, element): # see page 143, 149
    if element in self.lon:
      self.lon.remove(element)
    else:
      raise KeyError('Some error message')
  def __eq__(self, other):
    return self.issuperset(other) and self.issubset(other)
def main():
    s = HashSet(list(range(100)))
    t = HashSet(list(range(10,20)))
    u = HashSet(list(range(10,20)))
    if len(t) == len(u) and len(t) == 10:
        print("Test 1 Passed")
    else:
        print("Test 1 Failed")
        
    s.intersection_update(t)
    
    if len(s) == 10:
        print("Test 2 Passed")
    else:
        print("Test 2 Failed")
        
    s = HashSet(list(range(100)))
    
    t.update(s)
    
    if len(s) == len(t):
        print("Test 3 Passed")
    else:
        print("Test 3 Failed")
        
    t.clear()
    t.update(u)
    
    if len(t) == len(u):
        print("Test 4 Passed")
    else:
        print("Test 4 Failed")
        
    s.difference_update(t)
    
    test5Passed = True
    test6Passed = True
    
    for x in range(1,10):
        if x in s:
            pass
        else:
            test5Passed = False
            print("Test 5 Failed on",x)
            
        if x not in s:
            test6Passed = False
            print("Test 6 Failed on",x)
            
    if test5Passed:
        print("Test 5 Passed")
    
    if test6Passed:
        print("Test 6 Passed")
        

    test7Passed = True
    test8Passed = True
    
    for x in range(20,100):
        if x in s:
            pass
        else:
            test7Passed = False
            print("Test 7 Failed on",x)
            
        if x not in s:
            test8Passed = False
            print("Test 8 Failed on",x)
            
    if test7Passed:
        print("Test 7 Passed")
    
    if test8Passed:
        print("Test 8 Passed")   
        
    x = HashSet(["a","b","c","d","e","f","g","h","i","j","k"])
    
    y = HashSet(["c","d","e","l","m","n"])
    
    z = x.difference(y)
    
    if len(z) == 8:
        print("Test 9 Passed")
    else:
        print("Test 9 Failed")
        
    test10Passed = True
    
    for item in z:
        if item not in ["a","b","f","g","h","i","j","k"]:
            test10Passed = False
            print("Test 10 Failed on", x)
            
    if test10Passed:
        print("Test 10 Passed")
        
    if z.issubset(x):
        print("Test 11 Passed")
    else:
        print("Test 11 Failed")
        
    if x.issuperset(z):
        print("Test 12 Passed")
    else:
        print("Test 12 Failed")
        
    if z == y:
        print("Test 13 Failed")
    else:
        print("Test 13 Passed")
        
    if z == z:
        print("Test 14 Passed")
    else:
        print("Test 14 Failed")
        
    r = z.copy()
    
    if r == z:
        print("Test 15 Passed")
    else:
        print("Test 15 Failed")
    
    for item in range(50):
        z.add(item)
        
    for item in range(50):
        z.discard(item)
        
    if r == z:
        print("Test 16 Passed")
    else:
        print("Test 16 Failed")    
        
    for item in range(50):
        z.add(item)
        
    for item in range(50):
        z.remove(item)  
    
    if r == z:
        print("Test 17 Passed")
    else:
        print("Test 17 Failed")    
   
    
if __name__ == "__main__":
    main()
