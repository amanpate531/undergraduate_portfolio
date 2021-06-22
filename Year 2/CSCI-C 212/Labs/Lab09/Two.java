import javax.swing.*;
import java.awt.event.*;
import java.awt.*;

class Two extends JFrame implements ActionListener, KeyListener {
  public Two() {
    
    panel.setLayout(null);
    panel.setPreferredSize( new Dimension (353, 112)); 
    
    
    cartonLabel.setBounds(15, 15, 150, 20);
    panel.add(cartonLabel);
    
    
    cartonTextField.setBounds(148, 16, 38, 20);
    cartonTextField.setHorizontalAlignment(4);
    panel.add(cartonTextField);
    cartonTextField.addKeyListener(this);
    
    
    itemLabel.setBounds(15, 42, 150, 20);
    panel.add(itemLabel);
        
    
    itemTextField.setBounds(148, 43, 38, 20);
    itemTextField.setHorizontalAlignment(4);
    panel.add(itemTextField);
    itemTextField.addKeyListener(this);
    
    
    totalLabel.setBounds(198, 15, 80, 20);
    panel.add(totalLabel);
    
    
    result.setBounds(240, 15, 90, 21);
    result.setEditable(false);
    result.setHorizontalAlignment(4);
    panel.add(result);
    
    
    action.setBounds(198, 43, 120, 20);
    panel.add(action);
    action.addActionListener(this);
    
    this.add(panel);
    this.setVisible(true);
    this.setSize(400, 170);
    this.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
  }
  
  @Override
  public void actionPerformed(ActionEvent e) {
    int a, b, c;
    a = Integer.parseInt(cartonTextField.getText());
    b = Integer.parseInt(itemTextField.getText());
    c = a * b;
    result.setText(String.valueOf(c));
  }
  public void keyPressed(KeyEvent e) {
    result.setText("");
  }
  public void keyTyped(KeyEvent e) { }
  public void keyReleased(KeyEvent e) { }
  
  private final JButton action = new JButton("Calculate Total");
  private final JTextField result = new JTextField("   ");
  private final JLabel cartonLabel = new JLabel("Cartons per shipment: ");
  private final JLabel itemLabel = new JLabel("Items per carton: ");
  private final JTextField cartonTextField = new JTextField("0");
  private final JTextField itemTextField = new JTextField("0");
  private final JLabel totalLabel = new JLabel("Total: ");
  private final JPanel panel = new JPanel();
  
  public static void main(String[] args) {
    Two frame = new Two();
  }
}