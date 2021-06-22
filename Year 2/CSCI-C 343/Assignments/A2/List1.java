import java.util.function.Predicate;
import java.util.Comparator;
import java.util.*;

class EmptyListE extends Exception {}

abstract class List1<E> {
    /**
     The first three methods below are as written in class.
     */
    abstract int length ();
    abstract boolean isEmpty();
    abstract List1<E> append (List1<E> ys);

    /**
     The next three methods are simple getters, except that they
     might throw exceptions if the list does not have enough
     elements.
     */
    abstract E getFirst() throws EmptyListE;
    abstract E getSecond() throws EmptyListE;
    abstract List1<E> getRest() throws EmptyListE;

    /**
     The method 'triplicate' returns a new list in which every
     element is repeated three times.
     */
    abstract List1<E> triplicate();

    /**
     The method 'filter' takes a predicate on values of type E
     (which is a function of one argument of type E that returns a
     boolean) and returns a new list that only includes those
     elements from the current list that satisfy the predicate.
     */
    abstract List1<E> filter (Predicate<E> p);

    /**
     The static method 'makeIntList1' takes a size and a bound and
     returns a list of the given size in which every element a
     random number between 0 and bound-1. You can produce such
     numbers using the class System.Random.
     */
    static List1<Integer> makeIntList1 (int size, int bound) {
        List1<Integer> result = new Empty<>();
        for (int i = 0; i < size; i++) {
            result = new Node<>((int)(Math.random()*bound), result);
        }
        return result;
    }

    /**
     The static method 'sort2' takes two elements of type E and a
     comparison function that compares values of type E and returns
     a list of two elements in the sorted order.
     */
    static <E> List1<E> sort2 (E e1, E e2, Comparator<E> c) {
        List<E> result = new LinkedList<>();
        result.add(e1);
        result.add(e2);
        result.sort(c);
        return new Node<>(result.get(0), new Node<>(result.get(1), new Empty<>()));
    }

    /**
     The static method 'quicksort' sorts a list by the order implied
     by the given comparator. The method works as follows:
     - if the list is of size 0 or 1, then it is already sorted
     - if the list is of size 2 then use the method 'sort2' to produce the result
     - otherwise, let the first element be called 'e' and the rest be called 'r'.
     Use the method filter on 'r' twice to produce one sublist of all the elements
     that are < e and another sublist of all the elements >= e. Recursively call
     quicksort on the sublists and use append to produce the combined sorted list.
     The entire implementation shoudl take a few lines of code. If your code starts
     getting too big, then stop and start again.
     */

     static <E> List1<E> quickSort (List1<E> xs, Comparator<E> c) throws EmptyListE {
        if ((xs.length() == 0) || (xs.length() == 1)) {
            return xs;
        }
        else if(xs.length() == 2) {
            return sort2(xs.getFirst(), xs.getSecond(), c);
        }
        else {
            return xs;
            /*E e = xs.getFirst();
            List1<E> r = xs.getRest();
            return quickSort(r.filter(e1 -> (compare(e1, e) < 0)), c).append(quickSort(r.filter((e1 -> (compare((int)e, e1) < 0)), c)));
            */
        }
    }

}

class Empty<E> extends List1<E> {
    int length() {return 0;}
    boolean isEmpty () { return true; }
    List1<E> append (List1<E> ys) { return ys; }
    List1<E> triplicate() {return new Empty<>();}
    E getFirst() {
        return null;}
    E getSecond() {return null;}
    List1<E> getRest() {return null;}
    List1<E> filter(Predicate<E> p) {return new Empty<>();}
}

class Node<E> extends List1<E> {
    private E data;
    private List1<E> rest;
    Node(E data, List1<E> rest) {
        this.data = data;
        this.rest = rest;
    }
    int length() {return 1 + rest.length();}
    List1<E> append(List1<E> ys) {return new Node<>(data, rest.append(ys));}
    boolean isEmpty() {return false;}
    E getFirst() {return this.data;}
    E getSecond() throws EmptyListE {
        if (this.length() == 1) {
            return null;
        }
        else return this.rest.getFirst();
    }
    List1<E> getRest() {return this.rest;}
    List1<E> triplicate() {
        return new Node<>(this.data, new Node<>(this.data, new Node<>(this.data, this.rest.triplicate())));
    }
    List1<E> filter(Predicate<E> p) {
        List1<E> res = new Empty<>();
        if (p.test(this.data)) {
            res.append(new Node<>(this.data, new Empty<>()));
        }
        this.rest.filter(p);
        return res;
    }
}


