public class Dice {
  public static void main(String[] args) {
    Game1();
    Game2();
  }
  public static void Game1() {
    int wins = 0;
    for (int i = 0; i < 1000000; i++) {
      int sixes = 0;
      for (int j = 0; j < 4; j++) {
        int rand = (int)((Math.random() * 6 + 1));
        if (rand == 6) {
          sixes++;
        }
      }
      if (sixes >=1) {
        wins++;
      }
    }
    System.out.println("Game 1");
    System.out.println("-------");
    System.out.println("Wins: " + wins);
    System.out.println("Losses: " + (1000000 - wins));
  }
  public static void Game2() {
    int wins = 0;
    for (int i = 0; i < 1000000; i++) {
      int sixes = 0;
      for (int j = 0; j < 24; j++) {
        int rand = (int)((Math.random() * 6 + 1));
        if (rand == 6) {
          sixes++;
        }
      }
      if (sixes >= 2) {
        wins++;
      }
    }
    System.out.println("Game 2");
    System.out.println("-------");
    System.out.println("Wins: " + wins);
    System.out.println("Losses: " + (1000000 - wins));
  }
}