public class LetterTester
{
  public static void main(String[] args)
  {
    Letter Joanna = new Letter("Joanna", 8, 4);
    Joanna.dayLater();
    Joanna.extraLine();
    Joanna.extraLine();
    Joanna.dayEarlier();
    Joanna.dayLater();
    System.out.println(Joanna.getName());
    System.out.println("Expected: Joanna");
    System.out.println(Joanna.getDay());
    System.out.println("Expected: 9");
    System.out.println(Joanna.getLength());
    System.out.println("Expected: 6");
  }
}