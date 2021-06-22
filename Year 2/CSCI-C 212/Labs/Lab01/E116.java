import javax.swing.JOptionPane;

public class E116
{
  public static void main(String[] args)
  {
    String name = JOptionPane.showInputDialog("What is your name?");
    System.out.print("Hello, ");
    System.out.print(name);
  }
}