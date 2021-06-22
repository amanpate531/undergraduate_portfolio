import java.util.ArrayList;

public class Sequence {
  private ArrayList<Integer> values;
  public Sequence() {
    this.values = new ArrayList<Integer>();
  }
  public Sequence(int[] values){
    this();
    for (int v: values)
      this.values.add( v);
  }
  public void add(int n) {
    this.values.add(n);
  }
  public String toString() {
    return this.values.toString();
  }
  public Sequence longest(Sequence a) {
    Sequence b = new Sequence();
    int temp = a.values.get(0);
    b.values.add(temp);
    for (int i = 1; i < a.values.size(); i++) {
      if (a.values.get(i) > temp) {
        b.values.add(a.values.get(i));
        temp = a.values.get(i);
      }
      else break;
    }
    System.out.println(b.values.toString());
    return b;
  }
  public Sequence merge(Sequence a, Sequence b) {
    Sequence c = new Sequence();
    for (int i = 0; i < a.values.size(); i++) {
      for (int j = 0; j < b.values.size(); j++) {
        if (a.values.get(i) < b.values.get(j)) {
          c.values.add(a.values.get(i));
          a.values.remove(i);
        }
        else if (a.values.get(i) > b.values.get(j)) {
          c.values.add(b.values.get(j));
          b.values.remove(j);
        }
        else {
          c.values.add(a.values.get(i));
          c.values.add(b.values.get(j));
          a.values.remove(i);
          b.values.remove(j);
        }
      }
    }
    return c;
  }
  public Sequence sort(Sequence a) {
    Sequence b = new Sequence();
    if (a.values.size() == 0) {
      return a;
    }
    else {
      b = a.merge(a.longest(a), a.sort(a.rest(a)));
      System.out.println(b.values.toString());
      return b;
    }
  }
  public Sequence rest(Sequence a) {
    Sequence b = new Sequence();
    Sequence c = new Sequence();
    b = a.longest(a);
    if (b.values.size() == a.values.size()) {
      return c;
    }
    else {
      for (int i = 0; i < b.values.size(); i++) {
        a.values.remove(0);
      }
      return a;
    }
  }
  public static void main(String[] args) {
    Sequence w = new Sequence( new int[] {1, 2, 3, 7, 5, 6} );
    System.out.println( w );
    System.out.println(w.merge(w, w).values.toString());
  }
}