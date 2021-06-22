import java.util.Random;
import java.util.Arrays;

public class randArray {
  public static void main(String[] args) {
    int[] values = new int[10];
    Random rand = new Random();
    for (int i = 0; i < 10; i++) {
      int randint = rand.nextInt(20) + 1;
      values[i] = randint;
    }
    System.out.println(Arrays.toString(values));
    for (int j = 0; j < 10; j++) {
      int randomint = rand.nextInt(20) + 1;
      for (int k = 0; k < 10; k++) {
        while (values[k] == randomint) {
          randomint = rand.nextInt(20) + 1;
        }
      }
      values[j] = randomint;
    }
    System.out.println(Arrays.toString(values));
  }
}

// Forgot int in for loops in lines 8, 13, and 15 (-1.5 points)
// Wrong syntax for random number generating in lines 9, 14, and 17 (-1.5 points)
// Question score: 30/33