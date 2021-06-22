public class CarTester
{
  public static void main(String[] args)
  {
    Car test = new Car(20);
    test.addGas(20);
    test.drive(300);
    test.addGas(25);
    test.drive(480);
    System.out.println(test.getGasInTank());
    System.out.println("Expected: 6.0");
    System.out.println(false + "word");
    System.out.println(" ___\n ('v')\n (( ))\n-/-\"---\"--\n");
  }
}