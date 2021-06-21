class Queue:

    def __init__(self):
        self.list = []

    def dequeue(self):
        if self.isEmpty():
            return "Your queue is empty."
        res = self.front()
        self.list = self.list[1:]
        return res

    def enqueue(self, item):
        self.list.append(item)

    def front(self):
        if self.isEmpty():
            return "Your queue is empty."
        return self.list[0]

    def isEmpty(self):
        return len(self.list) == 0

def main():
    a = Queue()
    print(a.isEmpty())
    print(a.front())
    a.enqueue(5)
    print(a.list)
    print(a.dequeue())
    print(a.dequeue())
    a.enqueue(2)
    print(a.front())
    print(a.isEmpty())

if __name__ == "__main__":
    main()
