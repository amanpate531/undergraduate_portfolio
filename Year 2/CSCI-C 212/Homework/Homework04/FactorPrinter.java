import java.util.*;

public class FactorPrinter {
  public static void main(String[] args) {
    Scanner s;
    s = new Scanner(System.in);
    String n = s.nextLine();
    int a = Integer.parseInt(n);
    FactorGenerator b = new FactorGenerator(a);
    while (b.hasMoreFactors()) {
      System.out.println(b.nextFactor());
    }
    s.close();
  }
}