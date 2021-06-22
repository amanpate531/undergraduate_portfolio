public class Main {

    /**
     After you finish both List1 and List2 and test them thoroughly,
     you can use the code below to compare your implementation of
     sorting to the one provided by the Java library. Vary the list
     sizes below and provide a table comparing your implementation
     to the Java one for different list sizes.
     */
    public static void main(String[] args) throws EmptyListE{
        List1<Integer> xs = List1.makeIntList1(3000, 100);
        List2<Integer> ys = List2.makeIntList2(3000, 100);

        long startTime = System.nanoTime();
        List1.quickSort(xs,Integer::compareTo);
        long endTime = System.nanoTime();
        long duration1 = (endTime - startTime) / 1000000;

        startTime = System.nanoTime();
        ys.sort(Integer::compareTo);
        endTime = System.nanoTime();
        long duration2 = (endTime - startTime) / 1000000;

        System.out.printf("List1 time (ms) = %d%n", duration1);
        System.out.printf("List2 time (ms) = %d%n", duration2);
    }
}
