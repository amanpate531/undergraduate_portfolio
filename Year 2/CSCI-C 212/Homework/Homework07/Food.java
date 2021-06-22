import java.awt.Graphics; 
import java.awt.Color;
import java.util.ArrayList; 
import java.util.Arrays;
public class Food {
  
  private ArrayList<Circle> data;
  int[] xpos = new int[5];
  int[] ypos = new int[5];
  public Food() {
    this.data = new ArrayList<Circle>(); 
    for (int i = 0; i < 5; i++) {
      int x = closest((int) (25 + 350 * Math.random()));
      int y = closest((int) (25 + 350 * Math.random()));
      this.data.add(new Circle(x, 
                               y, 
                               Snake.R, 
                               Color.YELLOW, 
                               Color.GREEN));
      xpos[i] = x;
      ypos[i] = y;
    }
  }
  
  public int xFood(int l) {
    return xpos[l];
  }
  public int yFood(int m) {
    return ypos[m];
  }
  public void show(Graphics g) {
    for (Circle c : this.data)
      c.draw(g); 
  }
  public int closest(int j) {
    for (int k = 0; k < 25; k++) {
      if ((j < (16 * k)) && (j > (16 * (k - 1)))) {
      j = 16 * k;
      }
    }
    return j;
  }
}