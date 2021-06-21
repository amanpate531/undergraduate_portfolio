class BST:

    def __init__(self, root, left, right):
        self.root = root
        self.left = left
        self.right = right

    def display(self):
        lines, *_ = self._display_aux()
        for line in lines:
            print(line)

    def _display_aux(self):
        """Returns list of strings, width, height, and horizontal coordinate of the root."""
        # No child.
        if self.right is None and self.left is None:
            line = '%s' % self.root
            width = len(line)
            height = 1
            middle = width // 2
            return [line], width, height, middle

        # Only left child.
        if self.right is None:
            lines, n, p, x = self.left._display_aux()
            s = '%s' % self.root
            u = len(s)
            first_line = (x + 1) * ' ' + (n - x - 1) * '_' + s
            second_line = x * ' ' + '/' + (n - x - 1 + u) * ' '
            shifted_lines = [line + u * ' ' for line in lines]
            return [first_line, second_line] + shifted_lines, n + u, p + 2, n + u // 2

        # Only right child.
        if self.left is None:
            lines, n, p, x = self.right._display_aux()
            s = '%s' % self.root
            u = len(s)
            first_line = s + x * '_' + (n - x) * ' '
            second_line = (u + x) * ' ' + '\\' + (n - x - 1) * ' '
            shifted_lines = [u * ' ' + line for line in lines]
            return [first_line, second_line] + shifted_lines, n + u, p + 2, u // 2

        # Two children.
        left, n, p, x = self.left._display_aux()
        right, m, q, y = self.right._display_aux()
        s = '%s' % self.root
        u = len(s)
        first_line = (x + 1) * ' ' + (n - x - 1) * '_' + s + y * '_' + (m - y) * ' '
        second_line = x * ' ' + '/' + (n - x - 1 + u + y) * ' ' + '\\' + (m - y - 1) * ' '
        if p < q:
            left += [n * ' '] * (q - p)
        elif q < p:
            right += [m * ' '] * (p - q)
        zipped_lines = zip(left, right)
        lines = [first_line, second_line] + [a + u * ' ' + b for a, b in zipped_lines]
        return lines, n + m + u, max(p, q) + 2, n + u // 2

    def insert(self, item):
        if self.root == item:
            pass
        elif self.root > item:
            if self.left == None:
                self.left = BST(item, None, None)
            else: self.left.insert(item)
        else:
            if self.right == None:
                self.right = BST(item, None, None)
            else: self.right.insert(item)

    def __str__(self):
        return "(" + str(self.root) + " " + (" ." if self.left is None else str(self.left)) + " " + (" ." if self.right is None else str(self.right)) + ")"

    def search(self, item):
        if self.root == item:
            return True
        elif self.root < item:
            if self.right == None:
                return False
            else: return self.right.search(item)
        else:
            if self.left == None:
                return False
            else: return self.left.search(item)

    def delete(self, item):
        # 1: Node is a leaf (remove w/ no shift)
        # 2: Node has one child (child becomes parent)
        # 3: Node has two children (find max of left tree, promote to parent)
        if item == self.root:
            if self.left != None:
                a = findLargest(self.left)
                return BST(a, removeNode(self.left, a), self.right)
            elif self.right != None:
                a = findSmallest(self.right)
                return BST(a, self.left, removeNode(self.right, a))
            else:
                return None
        elif item > self.root:
            return BST(self.root, self.left, removeNode(self.right, item))
        else:
            return BST(self.root, removeNode(self.left, item), self.right)
        
def findLargest(tree):
    while tree.right != None:
        tree = tree.right
    return tree.root

def findSmallest(tree):
    while tree.left != None:
        tree = tree.left
    return tree.root

def removeNode(tree, item):
    if tree.search(item):
        if tree.root == item:
            if tree.left == None:
                return tree.right
            elif tree.right == None:
                return tree.left
            else:
                return tree.delete(item)
        elif tree.root < item:
            return BST(tree.root, tree.left, removeNode(tree.right, item))
        else:
            return BST(tree.root, removeNode(tree.left, item), tree.right)
            
    
def main():
    a = BST(1, None, None)
    a.insert(3)
    a.insert(4)
    a.insert(2)
    a.insert(7)
    a.insert(5)
    a.insert(6)
    print("Original tree")
    a.display()
    a = a.delete(1)
    print("Delete 1:")
    a.display()
    print("Delete 2:")
    a = a.delete(2)
    a.display()
    a.insert(1)
    print("Insert 1:")
    a.display()

if __name__ == "__main__":
    main()
