public class FactorGenerator extends FactorPrinter{
  int n;
  int temp;
  boolean b;
  public FactorGenerator(int number) {
    this.n = number;
  }
  public int getNumber() {
    return this.n;
  }
  public int nextFactor() {
    for (int i = 2; i < this.n; i++) {
      if ((this.n % i) == 0) {
        temp = this.n / i;
      }
    }
    this.n = this.n / temp;
    return temp;
  }
  public boolean hasMoreFactors() {
    boolean b = false;
    for (int j = 1; j < this.n; j++) {
      if ((this.n % j) == 0) {
        b = true;
      }
    }
    return b;
  }
}