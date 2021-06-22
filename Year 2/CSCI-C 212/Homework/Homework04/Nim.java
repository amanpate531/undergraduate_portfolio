import java.util.*;

public class Nim {
  int remove;
  public static void main(String[] args) {
    Scanner s;
    s = new Scanner(System.in);
    int size = (int)(Math.random() * 90 + 10);
    int firstTurn = (int)(Math.random() * 2);
    int comp = (int)(Math.random() * 2);
    while (size > 1) {
      System.out.println("Marbles remaining: " + size);
      if (firstTurn == 1) {
        int half = size / 2;
        int remove = 0;
        do {
          System.out.print("How many marbles would you like to remove? Must be less than " + half + ": ");
          remove = s.nextInt();
        }
        while ((remove != 1) && ((remove <= 0) || (remove > half)));
          size = size - remove;
          System.out.println("Marbles remaining after computer's move: " + size);
          firstTurn = 0;
      }
      else {
        int remove = 0;
        if (comp == 0) {
          remove = (int)(Math.random() * (size / 2) + 1);
        }
        else if (comp == 1) {
          if ((size == 3) || (size == 7) || (size == 15) || (size == 31) || (size == 63)) {
            remove = (int)(Math.random() * (size / 2) + 1);
          }
          else {
            if (size > 63) {
              remove = size - 63;
            }
            else if (size > 31) {
              remove = size - 31;
            }
            else if (size > 15) {
              remove = size - 15;
            }
            else if (size > 7) {
              remove = size - 7;
            }
            else if (size > 3) {
              remove = size - 3;
            }
          }
        }
        size = size - remove;
        System.out.println("Marbles remaining after computer's move: " + size);
        firstTurn = 1;
      }
    }
    if (firstTurn == 0) {
      System.out.println("You win!");
    }
    else {
      System.out.println("Computer wins. :( ");
    }
    s.close();
  }
}

