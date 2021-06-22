import java.util.*;

public class PrimePrinter {
  boolean prime;
  public static void main(String[] args) {
    Scanner s;
    s = new Scanner(System.in);
    int a = s.nextInt();
    PrimeGenerator b = new PrimeGenerator(a);
    boolean prime = true;
    while (a != 0) {
      if (a == 1) break;
      for (int i = 2; i < a; i++) {
        if ((a % i) == 0) {
          prime = false;
          break;
        }
      }
      if (prime) {
        System.out.println(a);
      }
      a--;
      prime = true;
    }
    s.close();
  }
}