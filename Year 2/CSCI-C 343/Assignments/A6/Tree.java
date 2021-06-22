import java.util.Random;

class EmptyTreeE extends Exception {}

/**
 * This hierarcy implements m-ary trees.
 * An m-ary tree is either empty, or
 * it is a node with a list of m-subtrees
 *
 * The parameter m is often called the branchingFactor
 *
 * It is convenient to recognize trees with no children which are
 * called 'leaves'. Technically an m-leaf is an m-ary tree with
 * one node and a list of length m of empty subtrees.
 *
 * In the three methods makeTree* below, you may assume the incoming
 * parameter is tuned to create a perfect tree in which every level
 * has the same number of nodes. So for example for a branching
 * factor of 3, you can assume the argument n to makeTreeNodes will be
 * one of:
 * 0, 1, 1+3, 1+3+9, 1+3+9+27, 1+3+9+27+81, ...
 * and nothing else. This simplifies your implementation considerably.
 * We will never test your code with other numbers.
 *
 * The Random number generator and bound are used to create the data
 * at each node: use r.nextInt(bound). We will not assume you are
 * creating the nodes in any particular order.
 */
abstract class Tree<E> {
    int h;
    int m;
    int n;
    E data;
    List<Tree<E>> li;
    Tree (int n, int m, int h, E data, List<Tree<E>> li) {
        this.n = n;
        this.m = m;
        this.h = h;
        this.data = data;
        this.li = li;
    }
    abstract E getData() throws EmptyTreeE;
    abstract List<Tree<E>> getChildren() throws EmptyTreeE;

    abstract boolean isEmpty();
    abstract boolean isLeaf();

    abstract int getBranchingFactor();
    abstract int getNumberOfNodes();
    abstract int numberOfInternalNodes();
    abstract int numberOfLeaves();
    abstract int getHeight();

    static <E> Tree<E> makeLeaf(E elem, int m) {
        return new NodeT<>(1, m, 1, elem, new EmptyL<>());
    }

    /*
     * Assume that 'n' is perfect
     */
    static Tree<Integer> makeTreeNodes(int n, int m, Random r, int bound) {
        if (n == 0) {
            return new EmptyT<>(m);
        }
        else {
            List<Integer> master = List.MakeIntList(r, bound, n);
            Tree<Integer> res = new EmptyT<>(m);

            return res;
        }
    }

    static Tree<Integer> makeTreeInternals(int i, int m, Random r, int bound) {
        if((m * i) == 0) {
            return new NodeT<>(1, m, 1, r.nextInt(bound), new EmptyL<>());
        }
        int n = m * i + 1;
        return makeTreeNodes(n, m, r, bound);
    }

    static Tree<Integer> makeTreeLeaves(int ell, int m, Random r, int bound) {
        int num = m * ell - 1;
        int den = m - 1;
        return makeTreeNodes(num / den, m, r, bound);
    }

}

class EmptyT<E> extends Tree<E> {
    EmptyT (int m) {
        super(0, m, 0, null, new EmptyL<>());
    }
    E getData() throws EmptyTreeE {
        throw new EmptyTreeE();
    }
    List<Tree<E>> getChildren() throws EmptyTreeE {
        throw new EmptyTreeE();
    }

    boolean isEmpty() {
        return true;
    }
    boolean isLeaf() {
        return false;
    }

    int getBranchingFactor() {
        return this.m;
    }
    int getNumberOfNodes() {
        return 0;
    }
    int numberOfInternalNodes() {
        return 0;
    }
    int numberOfLeaves() {
        return 0;
    }
    int getHeight() {
        return 0;
    }
}

class NodeT<E> extends Tree<E> {
    NodeT (int n, int m, int h, E data, List<Tree<E>> li) {
        super(n, m, h, data, li);
    }

    E getData() {
        return this.data;
    }
    List<Tree<E>> getChildren() {
        return this.li;
    }
    boolean isEmpty() {
        return false;
    }
    boolean isLeaf() {
        return this.numberOfInternalNodes()==0;
    }

    int getBranchingFactor() {
        return this.m;
    }
    int getNumberOfNodes() {
        return this.n;
    }
    int numberOfInternalNodes() {
        return (n - 1) / m;
    }
    int numberOfLeaves() {
        return (((m - 1) * n) + 1) / m;
    }
    int getHeight() {
        return this.h;
    }
}


