filter = [0] * 13
words = []

def hash(string, size):
  sum = 0
  for i in range(0, len(string)):
    sum += 2 * ord(string[i]) + 5 * (size - i)
  return sum % size

def insert(string, size):
  filter[hash(string, size)] = 1
  words.append(string)

def find(string, size):
    if filter[hash(string, size)] == 1:
        print(string + " is probably present...")
        if string not in words:
            print("sorry, false positive")
    else:
        print(string + " is definitely not present")

  
def main():
  print(filter)
  insert("hello", len(filter))
  print(filter)
  insert("mister", len(filter))
  print(filter)
  insert("president", len(filter))
  print(filter)
  find("please", len(filter))
  find("go", len(filter))
  find("president", len(filter))
  
  
if __name__ == "__main__":
  main()
    
