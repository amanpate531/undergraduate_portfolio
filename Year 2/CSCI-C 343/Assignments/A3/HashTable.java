import java.util.ArrayList;
import java.util.LinkedList;
import java.util.function.BiFunction;
import java.util.*;

// -------------------------------------------------------

/**
 *
 * An exception to throw when attempting to insert elements into a
 * full hash table.
 *
 */
class TableFullE extends Exception {}

// -------------------------------------------------------

/**
 *
 * The abstract class for the four hash tables we will implement. The
 * file HashTableTest has four test cases that should produce the same
 * information as Figures 5.5, 5.11, 5.13, and 5.18 in the book. You
 * should implement many more test cases!!!
 *
 */
abstract class HashTable {
    abstract void insert (int key) throws TableFullE;
    abstract void delete (int key);
    abstract boolean search (int key);
}

// -------------------------------------------------------

/**
 *
 * An implementation of a hash table that uses separate chaining. The
 * constructor should take two arguments: an argument 'size' of type
 * int, and an argument 'hf' of type HashFunction. The constructor
 * should create an ArrayList of the given size and initialize each
 * entry in that ArrayList to an empty linked list. The three methods
 * should be implemented as described in the book. You should also
 * implement a toString method that returns a comprehensive string
 * showing the entire contents of the hash table for debugging and
 * testing purposes.
 *
 */
class HashSeparateChaining extends HashTable {
    int size;
    HashFunction hf;
    ArrayList<LinkedList<Integer>> ar;
    HashSeparateChaining(int size, HashFunction hf) {
        this.hf = hf;
        this.size = size;
        for (int i = 0; i < size; i++) {
            ar.add(new LinkedList<>());
        }
    }
    void insert(int i) {
        int index = hf.apply(i);
        if (!(ar.get(index).contains(i))) {
            ar.get(index).addFirst(i);
        }
    }
    void delete(int i) {
        int index = hf.apply(i);
        if (ar.get(index).contains(i)) {
            ar.get(index).remove(i);
        }
    }
    boolean search(int i) {
        int index = hf.apply(i);
        if (ar.get(index).contains(i)) return true;
        else return false;
    }

    public String toString() {
        return Arrays.toString(ar.toArray());
    }
}

// -------------------------------------------------------

/**
 *
 * Before implementing the next three variants of hash tables, we will
 * implement a small class hierarchy of hash tables entries. There are
 * three kinds of entries: an entry that contains an 'int' value, an
 * entry that is empty and hence available, and an entry that is
 * marked as deleted. A deleted entry is available for insertions but
 * cannot be marked as empty. See the book for details.
 *
 */
abstract class Entry {
    abstract boolean available ();
}

/**
 *
 * An instance of this class represents an entry that is
 * available. Don't forget to also implement a toString method.
 *
 */
class Empty extends Entry {
    boolean available() {
        return true;
    }
    Empty() {}
    public String toString() {
        return "";
    }
}

/**
 *
 * An instance of this class represents an entry that is
 * available. Don't forget to also implement a toString method.
 *
 */
class Deleted extends Entry {
    boolean available() {
        return true;
    }
    Deleted() {}
    public String toString() {
        return "*";
    }
}

/**
 *
 * A constructor of this class takes an 'int' representing a value
 * stored in the hash table. That entry is not available. Also don't
 * forget to implement a toString method.
 *
 */
class Value extends Entry {
    boolean available() {
        return false;
    }
    public int value;
    Value(int value) {
        this.value = value;
    }
    public String toString() {
        return "Full";
    }
}

// -------------------------------------------------------

/**
 *
 * This class, although abstract, will have a constructor and an
 * implementation of each of the three methods: insert, delete, and
 * search. (Also don't forget a toString method.) The constructor
 * should take three arguments: an argument 'size' of type int, an
 * argument 'hf' of type HashFunction, and an argument 'f' of type
 * BiFunction<Integer,Integer,Integer>. The constructor should create
 * an ArrayList of the given size and initialize each slot in that
 * array with an Empty entry. The construct should also define a
 * BiFunction<Integer,Integer,Integer> called 'dhf' as follows:
 *
 *   this.dhf = (key,index) -> (hf.apply(key) + f.apply(key,index)) % size;
 *
 * This auxiliary hash function applies the regular hash function 'hf'
 * and then modifies the result using the BiFunction 'f' that depends
 * on the current index in the hash table. The subclasses for linear
 * probing, quadratic probing, and double hashing, will each pass an
 * appropriate function 'f' to control the auxiliary function.
 *
 * Each of the methods insert, delete, and search takes a value 'key'
 * to process. Each of the methods will involve a loop that iterates
 * over all the positions in the ArrayList. At iteration 'i', an
 * integer position is calculated using:
 *
 *   int h = dhf.apply(key,i)
 *
 * For insert: if the position 'h' is available then the value 'key'
 * is stored.
 *
 * For delete: if position 'h' has an entry of kind 'Value' and if the
 * stored integer is identical to 'key' then the entry is marked as
 * deleted.
 *
 * For search: if position 'h' is Empty then the item is not found. If
 * position 'h' has an entry of kind 'Value' and if the stored value
 * is identical to 'key' then the item is found.
 *
 */
abstract class HashTableAux extends HashTable {
    int size;
    HashFunction hf;
    static BiFunction<Integer, Integer, Integer> f;
    static ArrayList<Entry> ar;
    HashTableAux(int size, HashFunction hf, BiFunction<Integer, Integer, Integer> f, ArrayList<Entry> ar) {
        this.size = size;
        this.hf = hf;
        this.f = f;
        this.ar = ar;
        for(int i = 0; i < size; i++) {
            ar.add(new Empty());
        }
    }
    BiFunction<Integer, Integer, Integer> dhf = (key, index) -> hf.apply(key) + f.apply(key, index) % size;
    void insert(int key) {
        for (int i = 0; i < size; i++) {
            int h = dhf.apply(key, i);
            if (this.ar.get(h) instanceof Empty) {
                ar.set(h, new Value(key));
            }
        }
    }
    void delete(int key) {
        for (int i = 0; i < size; i++) {
            int h = dhf.apply(key, i);
            if (!ar.get(h).available()) {
                Entry e = ar.get(h);
                Value v = (Value) e;
                if (v.value == key) {
                    ar.set(h, new Deleted());
                }
            }
        }
    }
    boolean search(int key) {
        boolean res = false;
        for (int i = 0; i < size; i++) {
            int h = dhf.apply(key, i);
            if (ar.get(h) instanceof Value) {
                Entry e = ar.get(h);
                Value v = (Value) e;
                if (v.value == key) {
                    res = true;
                }
            }
        }
        return res;
    }
    public String toString() {
        return Arrays.toString(ar.toArray());
    }

}

// -------------------------------------------------------


/**
 *
 * The only code in this class should be a constructor that takes two
 * arguments: an argument 'size' of type int and an argument 'hf' of
 * type HashFunction.
 *
 */
class HashLinearProbing extends HashTableAux {
    void insert(int i) {}
    void delete(int i) {}
    boolean search(int i) {return true;}
    int size;
    HashFunction hf;
    HashLinearProbing(int size, HashFunction hf) {
        super(size, hf, f, ar);
        this.size = size;
        this.hf = hf;
    }
}

// -------------------------------------------------------

/**
 *
 * The only code in this class should be a constructor that takes two
 * arguments: an argument 'size' of type int and an argument 'hf' of
 * type HashFunction.
 *
 */
class HashQuadProbing extends HashTableAux {
    void insert(int i) {}
    void delete(int i) {}
    boolean search(int i) {return true;}
    int size;
    HashFunction hf;
    HashQuadProbing(int size, HashFunction hf) {
        super(size, hf, f, ar);
        this.size = size;
        this.hf = hf;
    }
}

// -------------------------------------------------------

/**
 *
 * The only code in this class should be a constructor that takes
 * three arguments: an argument 'size' of type int, an argument 'hf'
 * of type HashFunction, and a third argument 'hf2' represents the
 * secondary hash function.
 *
 */
class HashDouble extends HashTableAux {
    void insert(int i) {}
    void delete(int i) {}
    boolean search(int i) {return true;}
    int size;
    HashFunction hf;
    HashFunction hf2;
    HashDouble(int size, HashFunction hf, HashFunction hf2) {
        super(size, hf, f, ar);
        this.size = size;
        this.hf = hf;
        this.hf2 = hf2;
    }
}

// -------------------------------------------------------
