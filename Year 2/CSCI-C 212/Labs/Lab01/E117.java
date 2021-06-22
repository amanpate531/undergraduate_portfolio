import javax.swing.JOptionPane;

public class E117
{
  public static void main(String[] args)
  {
    String name = JOptionPane.showInputDialog("What is your name?");
    System.out.print("Hello, ");
    System.out.println(name);
    String no = JOptionPane.showInputDialog("My name is Hal! What would you like me to do?");
    System.out.print("I'm sorry, ");
    System.out.print(name);
    System.out.print(". I'm afraid I can't do that.");
  }
}