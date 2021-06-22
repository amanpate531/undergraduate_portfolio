import java.util.*;

public class UnionSets {
  public static void main(String[] args) {
    Set<Integer> a = new HashSet<Integer>();
    Set<Integer> b = new HashSet<Integer>();
    Set<Integer> c = new HashSet<Integer>();
    a.add(1);
    a.add(4);
    a.add(9);
    b.add(1);
    b.add(3);
    b.add(5);
    b.add(7);
    b.add(9);
    c.addAll(a);
    c.addAll(b);
    System.out.println(a);
    System.out.println(b);
    System.out.println(c);
  }
}