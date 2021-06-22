import java.util.ArrayList; 
import java.util.Collections; 

public class Candidates {
  String name;
  int votes; // not private so I can simplify a little the comparisons 
  public Student(String name, int votes) {
    this.name = name;
    this.age = votes;
  }
  public String toString() {
    return "Student(" + this.name + ", " + this.age + ")";  
  }
  public static void main(String[] args) {
    ArrayList<Student> students = new ArrayList<Student>();  
    students.add( new Student("Laura" , 12) ); 
    students.add( new Student("Larry" , 13) ); 
    students.add( new Student("Leslie", 11) ); 
    students.add( new Student("Les", 11) ); 
    System.out.println( students );
    Collections.sort( students, new Ascending() );    
    System.out.println( students );
    Collections.sort( students, new Descending() );    
    System.out.println( students );
    
  }
}