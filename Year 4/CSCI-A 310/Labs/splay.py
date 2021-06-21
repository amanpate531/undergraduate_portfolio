# Aman Patel

import random

class SplayNode:

    def __init__(self, item):
        self.item = item
        self.right = None
        self.left = None
        self.parent = None

    def display(self):
        lines, *_ = self._display_aux()
        for line in lines:
            print(line)

    def _display_aux(self):
        """Returns list of strings, width, height, and horizontal coordinate of the root."""
        # No child.
        if self.right is None and self.left is None:
            line = '%s' % self.item
            width = len(line)
            height = 1
            middle = width // 2
            return [line], width, height, middle

        # Only left child.
        if self.right is None:
            lines, n, p, x = self.left._display_aux()
            s = '%s' % self.item
            u = len(s)
            first_line = (x + 1) * ' ' + (n - x - 1) * '_' + s
            second_line = x * ' ' + '/' + (n - x - 1 + u) * ' '
            shifted_lines = [line + u * ' ' for line in lines]
            return [first_line, second_line] + shifted_lines, n + u, p + 2, n + u // 2

        # Only right child.
        if self.left is None:
            lines, n, p, x = self.right._display_aux()
            s = '%s' % self.item
            u = len(s)
            first_line = s + x * '_' + (n - x) * ' '
            second_line = (u + x) * ' ' + '\\' + (n - x - 1) * ' '
            shifted_lines = [u * ' ' + line for line in lines]
            return [first_line, second_line] + shifted_lines, n + u, p + 2, u // 2

        # Two children.
        left, n, p, x = self.left._display_aux()
        right, m, q, y = self.right._display_aux()
        s = '%s' % self.item
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
        
class SplayTree:
    
    def insert(self, root, val):
        
        if root.left == None and val < root.item:
            new_leaf = SplayNode(val)
            new_leaf.parent = root
            root.left = new_leaf
            return self.splay(new_leaf, root)
        elif root.right == None and val >= root.item:
            new_leaf = SplayNode(val)
            new_leaf.parent = root
            root.right = new_leaf
            return self.splay(new_leaf, root)
        elif val < root.item:
            return self.insert(root.left, val)
        else:
            return self.insert(root.right, val)

        
    def search(self, root, val):
        if root.item == val:
            return self.splay(root, root.parent)
        elif root.item < val and root.right != None:
            return self.search(root.right, val)
        elif root.item > val and root.left != None:
            return self.search(root.left, val)
        else:
            print(val, "is not present.")
            return False

    def delete(self, root, value):
        temp = self.search(root, value)
        if temp == False:
            return root
        root = temp
        t1 = root.left
        t2 = root.right
        root = None
        if t1 is None and t2 != None:
            t2.parent = None
            return t2
        elif t2 is None and t1 != None:
            t1.parent = None
            return t1
        else:
            t1.parent = None
            t2.parent = None
            maxNode = self.get_maxNode(t1)
            t1 = self.splay(maxNode, maxNode.parent)
            t2.parent = t1
            t1.right = t2
            return t1
        

    def splay(self, node, parent):
        if parent == None:
            return node
        else:
            if parent.left is not None:
                if node.item == parent.left.item:
                    new_node = self.rightRotate(node)
                    return self.splay(new_node, new_node.parent)
            if parent.right is not None:
                if node.item == parent.right.item:
                    new_node = self.leftRotate(node)
                    return self.splay(new_node, new_node.parent)                

    def rightRotate(self, node):
        child = node.right
        parent = node.parent
        node.parent = parent.parent
        parent.left = child
        node.right = parent
        if child != None:
            child.parent = parent
        if parent.parent != None:
            if parent.parent.item <= parent.item:
                parent.parent.right = node
            else:
                parent.parent.left = node
        parent.parent = node
        return node
        
    
    def leftRotate(self, node):
        child = node.left
        parent = node.parent
        node.parent = parent.parent
        parent.right = child
        node.left = parent
        if child != None:
            child.parent = parent
        if parent.parent != None:
            if parent.parent.item <= parent.item:
                parent.parent.right = node
            else:
                parent.parent.left = node
        parent.parent = node
        return node

    def get_maxNode(self, root):
        if root.right == None:
            return root
        else:
            return self.get_maxNode(root.right)

        
def main():
    tree = SplayTree()
    root = SplayNode(50)
    a = [x for x in range(1, 101)]
    random.shuffle(a)
    for i in range(0, 10):
        root = tree.insert(root, a[i])
    root.display()
    root = tree.search(root, 50)
    root = tree.search(root, a[8])
    root.display()
    root = tree.delete(root, a[5])
    root.display()
    print(a[:10])
    
if __name__ == "__main__":
    main()
