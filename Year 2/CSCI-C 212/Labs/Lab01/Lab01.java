import java.math.BigDecimal;

public class Lab01
{
  public static void main(String[] args)
  {
    BigDecimal a, b, c, d, e;
    a = new BigDecimal("1");
    b = new BigDecimal("2");
    c = new BigDecimal("3");
    d = new BigDecimal("4");
    e = new BigDecimal("5");
    System.out.println(a.add(b));
    System.out.println(b.multiply(c));
    System.out.println(a.subtract(b.subtract(c.subtract(d))));
    System.out.println(a.subtract(b).subtract(c).subtract(d));
    System.out.println((b.multiply(c)).subtract(d.multiply(e)));
  }
}