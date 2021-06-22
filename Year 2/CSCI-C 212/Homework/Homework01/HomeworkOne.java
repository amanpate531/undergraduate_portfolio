import java.util.Scanner;

public class HomeworkOne
{
 public static void main(String[] args)
 {
  Scanner time;
  time = new Scanner(System.in);
  System.out.print("Enter the first time: ");
  String time1 = time.nextLine();
  System.out.print("Enter the second time: ");
  String time2 = time.nextLine();
  int h1 = Integer.parseInt(time1.substring(0,2));
  int min1 = Integer.parseInt(time1.substring(3,5));
  int h2 = Integer.parseInt(time2.substring(0,2));
  int min2 = Integer.parseInt(time2.substring(3,5));
  int d = ((((h2*60) + (min2)) - ((h1*60) + (min1)) + 1440) % 1440);
  int finalhr = (d / 60);
  int finalmin = (d % 60);
  System.out.println(finalhr + " hours and " + finalmin + " minutes.");
 }
}