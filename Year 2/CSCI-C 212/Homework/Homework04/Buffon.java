public class Buffon {
  static double yLow;
  static double angle;
  static double yHigh;
  static int hits;
  public static void main(String[] args) {
    for (int i = 0; i < 10000; i++) {
      yLow = Math.random() * 2;
      angle = Math.random() * 3.141592653;
      yHigh = yLow + Math.sin(angle);
      if (yHigh > 2) {
        hits++;
      }
    }
    System.out.println((float)(10000 / hits));
  }
}