import java.util.*;

public class IntersectionIterator {
  public static void main(String[] args) {
    LinkedList<Integer> a = new LinkedList<Integer>();
    ListIterator<Integer> iterator1 = a.listIterator();
    LinkedList<Integer> b = new LinkedList<Integer>();
    ListIterator<Integer> iterator2 = b.listIterator();
    LinkedList<Integer> c = new LinkedList<Integer>();
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
        int temp = iterator2.next();
        if((a.contains(temp))&& (iterator2.hasNext())) {
          c.add(temp);
        }
      }
      System.out.println(c);
    }
    else {
      while (iterator1.hasNext()) {
        int temp = iterator1.next();
        if((b.contains(temp))&& (iterator1.hasNext())) {
          c.add(temp);
        }
      }
      System.out.println(c);
    }
  }
}