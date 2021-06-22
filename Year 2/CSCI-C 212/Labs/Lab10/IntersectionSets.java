import java.util.*;

public class IntersectionSets {
  public static void main(String[] args) {
    Set<Integer> a = new HashSet<Integer>();
    Set<Integer> b = new HashSet<Integer>();
    a.add(1);
    a.add(4);
    a.add(9);
    b.add(1);
    b.add(3);
    b.add(5);
    b.add(7);
    b.add(9);
    System.out.println(a);
    System.out.println(b);
    a.retainAll(b);
    System.out.println(a);
  }
}