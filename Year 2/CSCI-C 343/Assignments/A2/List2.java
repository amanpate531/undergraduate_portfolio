import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Random;
import java.util.*;
import java.util.function.BiFunction;
import java.util.function.Predicate;

public class List2<E> {
    private LinkedList<E> deleg;

    List2() {
        this.deleg = new LinkedList<>();
    }

    E get (int index) {
        return deleg.get(index);
    }

    int length () {
        return deleg.size();
    }

    void add (E elem) {
        deleg.add(elem);
    }

    /**
     This is the same method from the class List1. Your solution must use
     the method listIterator to get an iterator for the list.
     */
    void triplicate () {
        LinkedList<E> result = new LinkedList<>();
        E current;
        ListIterator<E> it = this.deleg.listIterator();
        while (it.hasNext()) {
            current = it.next();
            result.add(current);
            result.add(current);
            result.add(current);
        }
        this.deleg = result;
    }

    /**
     This is the method sum we wrote in the Jan. 15 lecture for the
     List1 class.  Your solution for this class must use the method
     listIterator to get an iterator for the list.
     */
    E sum (E base, BiFunction<E,E,E> acc) {
        ListIterator<E> it = this.deleg.listIterator();
        while (it.hasNext()) {
            base = acc.apply(base, it.next());
        }
        return base;
    }

    /**
     The following method reverses the list using iterators. A
     simple idea is to the 'descendingIterator' method to traverse
     the list backwards and build the reversed list.
     */
    void reverse () {
        LinkedList<E> result = new LinkedList<>();
        E current;
        ListIterator<E> it = this.deleg.listIterator(this.deleg.size());
        while (it.hasPrevious()) {
            current = it.previous();
            result.add(current);
        }
        this.deleg = result;
    }

    /**
     The following method takes a predicate on values type E and
     returns the number of list elements that satisfy the
     predicate. Again use an iterator to traverse the list.
     */
    int countOccurrences (Predicate<E> pred) {
        int count = 0;
        ListIterator<E> it = this.deleg.listIterator();
        while (it.hasNext()) {
            if (pred.test(it.next())) {
                count++;
            }
        }
        return count;
    }

    void sort (Comparator<E> c) {
        deleg.sort(c);
    }

    /**
     This is similar to the method in List1.
     */
    static List2<Integer> makeIntList2 (int size, int bound) {
        LinkedList<Integer> result = new LinkedList<>();
        for (int i = 0; i < size; i++) {
            result.add((int)(Math.random() * bound));
        }
        List2<Integer> res = new List2<>();
        res.deleg = result;
        return res;
    }
}
