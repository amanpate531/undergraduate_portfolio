public class Letter
{
  private int length;
  private int day;
  private String name;
  public Letter(String name, int day, int length)
  {
    this.name = name;
    this.day = day;
    this.length = length;
  }
  public void dayLater()
  {
    this.day = day + 1;
  }
  public void dayEarlier()
  {
    this.day = day - 1;
  }
  public void extraLine()
  {
    this.length = length + 1;
  }
  public String getName()
  {
    return name;
  }
  public int getDay()
  {
    return day;
  }
  public int getLength()
  {
    return length;
  }
}