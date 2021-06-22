public class CounterTester
{
  public static void main(String[] args)
  {
    Counter test = new Counter();
    test.click();
    System.out.println(test.getValue());
    test.reset();
    System.out.println(test.getValue());
    test.click();
    System.out.println(test.getValue());
    System.out.println("Expected: 1");
  }
}