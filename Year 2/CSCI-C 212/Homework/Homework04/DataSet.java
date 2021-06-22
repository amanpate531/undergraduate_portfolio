import java.util.*;

public class DataSet {
  double sum;
  int count;
  static double min;
  static double max;
  public static void main(String[] args) {
    int count = 0;
    double sum = 0;
    double max = Double.MIN_VALUE;
    double min = Double.MAX_VALUE;
    while (true) {
      Scanner s;
      s = new Scanner(System.in);
      String n = s.nextLine();
      try {
        double a = Double.parseDouble(n);
        if (a > max) {
          max = a;
        }
        if (a < min) {
          min = a;
        }
        sum += a;
        count++;
        s.close();
      }
      catch (Exception e) {
        System.out.println("Sum: " + sum);
        System.out.println("Average: " + (sum / count));
        System.out.println("Max: " + max);
        System.out.println("Min: " + min);
        System.out.println("Range: " + (max - min));
        break;
      }
    }
  }
  public void add(double value) {
    sum += value;
  }
  public double getAverage() {
    return sum / count;
  }
  public double getSmallest() {
    return min;
  }
  public double getLargest() {
    return max;
  }
  public double getRange() {
    return max - min;
  }
}
  