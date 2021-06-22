public class Student
{
  private String name;
  private int total;
  private int count;
  private int average;
  private int score;
  public Student(String name, int total)
  {
    this.name = name;
    this.total = total * 5;
    this.count = 5; //Assume students have taken 5 quizzes to calculate average quiz score correctly
  }
    public String getName()
  {
      return name;
  }
  public void addQuiz(int score)
  {
    this.score = score;
    this.total = this.total + this.score;
    this.count = count + 1;
  }
  public int getTotalScore()
  {
    return this.total;
  }
  public int getAverageScore()
  {
    average = total / count;
    return average;
  }
}