public class PrimeGenerator extends PrimePrinter {
  int n;
  public int temp;
  boolean prime;
  public PrimeGenerator(int number) {
    this.n = number;
  }
  public boolean isPrime(int number) {
    boolean prime = true;
    for (int i = number; i > 1; i--) {
      if ((number % i) == 0) {
        prime = false;
        temp = number;
        break;
      }
    }
    return prime;
  }
  public int nextPrime(int number) {
    return temp;
    }
}