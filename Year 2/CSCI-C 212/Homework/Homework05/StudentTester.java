public class StudentTester
{
  public static void main(String[] args)
  {
    Student John = new Student("John", 87);
    John.addQuiz(100);
    John.addQuiz(84);
    John.addQuiz(95);
    System.out.println(John.getName());
    System.out.println("Expected: John");
    System.out.println(John.getTotalScore());
    System.out.println("Expected: 714");
    System.out.println(John.getAverageScore());
    System.out.println("Expected: 89");
  }
}
    