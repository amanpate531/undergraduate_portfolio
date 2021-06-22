import java.util.*;

public class UnionIterator {
  public static void main(String[] args) {
    LinkedList<Integer> a = new LinkedList<Integer>();
    ListIterator<Integer> iterator1 = a.listIterator();
    LinkedList<Integer> b = new LinkedList<Integer>();
    ListIterator<Integer> iterator2 = b.listIterator();
    iterator1.add(1);
    iterator1.add(4);
    iterator1.add(9);
    iterator1.add(16);
    iterator2.add(1);
    iterator2.add(3);
    iterator2.add(5);
    iterator2.add(7);
    iterator2.add(9);
    iterator2 = b.listIterator();
    iterator1 = a.listIterator();
    if (a.size() >= b.size()) {
      while (iterator2.hasNext()) {
        if((a.contains(iterator2.next()))&& !(iterator2.hasNext())) {
          break;
        }
        else
          a.add(iterator2.next());
      }
      System.out.println(a);
    }
    else {
      while (iterator1.hasNext()) {
        if((b.contains(iterator1.next())) && !(iterator1.hasNext())) {
          break;
        }
        else
          b.add(iterator1.next());
      }
      System.out.println(b);
    }
  }
}