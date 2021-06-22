import java.util.*;

public class MSD {
  double sum;
  int count;
  double sumSquares;
  public static void main(String[] args) {
    int count = 0;
    double sum = 0;
    double sumSquares = 0;
    while (true) {
      Scanner s;
      s = new Scanner(System.in);
      String n = s.nextLine();
      try {
        double a = Double.parseDouble(n);
        sum += a;
        sumSquares += (a * a);
        count++;
        s.close();
      }
      catch (Exception e) {
        System.out.println("Count: " + count);
        System.out.println("Average: " + (sum / count));
        System.out.println("Standard Deviation: " + Math.sqrt((sumSquares - ((Math.pow(sum, 2)) / count)) / (count - 1)));
        break;
      }
    }
    
  }
  public void add(double value) {
    sum += value;
  }
  public double getAverage() {
    return (sum / count);
  }
  public double getStandardDeviation() {
    return (Math.sqrt((sumSquares - (1 / count) * sum * sum)/(count - 1)));
  }
}