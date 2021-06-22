import java.util.Scanner;
import java.util.Random;

public class P4_22 {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        Random random = new Random();
        int sizeOfPile = random.nextInt(91) + 10;
        int currentTurn = random.nextInt(2);
        int computerIntellect = random.nextInt(2);

        while (sizeOfPile > 0) {
            System.out.printf("Number of marbles: %d\n", sizeOfPile);

            if (currentTurn == 1) {
                System.out.println("Your move!");
                int halfPileSize = sizeOfPile / 2;
                int marblesToRemove = 0;

                do {
                    System.out.printf("Choose number of marbles to remove from pile: ", halfPileSize);
                    marblesToRemove = input.nextInt();
                }
                while ((marblesToRemove != 1) && (marblesToRemove <= 0 || marblesToRemove > halfPileSize));
                
                sizeOfPile = sizeOfPile - marblesToRemove;
                System.out.printf("Size of pile after computer move is: %d\n", sizeOfPile);
                currentTurn = 0;
            }
            else {
                int countOfMarbles = 0;

                if (computerIntellect == 0) {
                    countOfMarbles = random.nextInt((sizeOfPile / 2)) + 1;
                }
                else if (computerIntellect == 1) {
                    if (sizeOfPile == 3 || sizeOfPile == 7 ||
                        sizeOfPile == 15 || sizeOfPile == 31 ||
                        sizeOfPile == 63) {
                        countOfMarbles = random.nextInt((sizeOfPile / 2)) + 1;
                    }
                    else {
                        if (sizeOfPile > 63) {
                            sizeOfPile = 63;
                        }
                        else if (sizeOfPile > 31) {
                            sizeOfPile = 31;
                        }
                        else if (sizeOfPile > 15) {
                            sizeOfPile = 15;
                        }
                        else if (sizeOfPile > 7) {
                            sizeOfPile = 7;
                        }
                        else if (sizeOfPile > 3) {
                            sizeOfPile = 3;
                        }
                    }
                }

                sizeOfPile = sizeOfPile - countOfMarbles;
                System.out.printf("Size of pile after computer move is: %d\n", sizeOfPile);
                currentTurn = 1;
            }
        }
        
        if (currentTurn == 0) {
            System.out.println("Computer wins!");
        }
        else {
            System.out.println("Human wins!");
        }

        input.close();
    }
}