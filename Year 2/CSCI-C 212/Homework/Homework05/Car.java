public class Car
{
  private double gasLeft;
  private double mileage;
  public Car(double mileage)
  {
    this.mileage = mileage;
    this.gasLeft = 0;
  }
  public double getGasInTank()
  {
    return this.gasLeft;
  }
  public void addGas(double amount)
  {
    this.gasLeft = gasLeft + amount;
  }
  public void drive(double length)
  {
    double consumedGas = length / mileage;
    this.gasLeft = this.gasLeft - consumedGas;
  }
}
  