import java.awt.Graphics;
import java.awt.Color;
import java.awt.Polygon;
import javax.swing.JComponent;

public class Lab02 extends JComponent {
  int width, height;
  public Lab02(int width, int height) {
    this.width = width;
    this.height = height;
  }
  public void paintComponent(Graphics g) {
    g.setColor(Color.WHITE);
    g.fillRect(x +  0, y +  0, scale(500), scale(500));
    g.setColor(new Color(165, 42, 42));
    g.fillRect(x + scale(100), y + scale(375), scale(300), scale(50));
    g.fillPolygon( new Polygon ( new int[] { x + scale(100), x + scale(50), x + scale(100) },
                                 new int[] { y + scale(425), y + scale(375),y + scale(375) },
                                 3
                                )
                    );
    g.fillPolygon( new Polygon ( new int[] { x + scale(400), x + scale(400), x + scale(450) },
                                 new int[] { y + scale(375), y + scale(425), y + scale(375) },
                                 3
                                 )
                    );
    g.fillRect( x + scale(50), y + scale(300), scale(400), scale(75));
    g.fillRect( x + scale(225), y + scale(75), scale(8), scale(325));
    g.setColor(new Color(192, 192, 192));
    g.fillPolygon( new Polygon ( new int[] { x + scale(233), x + scale(410), x + scale(233)},
                                 new int[] { y + scale(80), y + scale(280), y + scale(280)},
                                 3
                                 )
                    );
  }
}
    
  