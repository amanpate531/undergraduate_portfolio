import javax.swing.JComponent;
import javax.swing.JFrame;
import java.awt.Graphics; 

public class Boats extends JComponent {
  public static void main(String[] args) {
    JFrame frame = new JFrame(); 
    frame.setVisible(true); 
    int width = 500, height = 500;
    frame.setSize(width + 20, height + 40); 
    Boats drawing = new Boats(width, height); 
    frame.add(drawing);     
  }
  int width, height; 
  Boat a, b, c; 
  public Boats(int width, int height) {
    this.width = width;
    this.height = height; 
    a = new Boat( 1,  330, 0.25);                  
    b = new Boat(121, 230, 0.5);
    c = new Boat(361, 330, 0.25);
   }
  public void paintComponent(Graphics g) {
    a.draw(g); 
    b.draw(g); 
    c.draw(g);
  }
}