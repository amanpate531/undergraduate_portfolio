import java.net.URL;
import javax.swing.ImageIcon;
import javax.swing.JOptionPane;

public class E118
{
  public static void main(String[] args) throws Exception
  {
    URL imageLocation = new URL(
           "https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg");
    JOptionPane.showMessageDialog(null, "Hello, Visitor", "Puppy",
                                  JOptionPane.PLAIN_MESSAGE, new ImageIcon(imageLocation));
  }
}
