import java.util.*; 

public class Two {
  public static void main(String[] args) {
    int[] values = Two.fillRandomly(10, 1, 100); 
    System.out.println( "Result 1: " + java.util.Arrays.toString( values ) ); 
    values = Two.fillRandomlyNoDuplicates(10, 1, 100); 
    System.out.println( "Result 2: " + java.util.Arrays.toString( values ) ); 
    values = Two.fillRandomlyNoDuplicates(10, 1, 15); // try again with shorter range to force hits 
    System.out.println( "Result 3: " + java.util.Arrays.toString( values ) ); 
  }
  public static int[] fillRandomly(int size, int low, int high) {
    int[] result = new int[size]; 
    for (int i = 0; i < size; i++)
      result[i] = (int) (Math.random() * (high - low + 1) + 1);
    return result; 
  }
  public static int[] fillRandomlyNoDuplicates(int size, int low, int high) {
    int[] result = new int[10]; 
    for (int i = 0; i < 10; i++) {
      boolean good = true; 
      int number = (int) (Math.random() * (high - low + 1) + 1); // [1, 100] and integer 
      System.out.printf( "Trying new number %3d ... ", number ); 
      for (int j = 0; j < i; j++)  
        if (number == result[j]) { // if the value exists already, go back to try again 
          good = false; 
          i = i - 1;
          break; 
        }
      if (good) {
        result[i] = number;
        System.out.println( "     good: " + java.util.Arrays.toString( result ) );  
      } else 
        System.out.println( " not good: " + java.util.Arrays.toString( result ) );  
    }
    return result;
  }
}