import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.function.Function;

class DP {

    /**
     * Trivial example to show the pattern: fib
     * First write the normal recursive solution
     */
    static long fib (int n) {
        if (n < 2) return n;
        else return fib(n-1) + fib (n- 2);
    }

    /**
     * Create a hash table: please call it fibMemo as we will refer
     * to it from the test suite.
     */
    static Map<Integer,Long> fibMemo = new WeakHashMap<>();

    /**
     * Use the method computeIfAbsent passing the naive recursive
     * computation as an argument. Do not forget to rename the
     * recursive calls to refer to the memoized version.
     *
     * There will typically be small additional tweaks to do. In
     * this case, I had to explicitly cast from int to long
     * in the return clause for the base case.
     */
    static long mfib (int n1) {
        return fibMemo.computeIfAbsent(n1, n -> {
            if (n < 2) return (long)n;
            else return mfib(n - 1) + mfib(n - 2);
        });
    }

    /**
     * For fun... Compute fib using the golden ratio.
     */
    static long ffib (int n) {
        double p1 = 1.0 / Math.pow(5, 0.5);
        double p2 = (1.0 + Math.pow(5, 0.5)) / 2;
        double p3 = (1.0 - Math.pow(5, 0.5)) / 2;
        return (long)(p1 * (Math.pow(p2, n) - Math.pow(p3, n)));
    }

    // -----------------------------------------------------------------------------
    // Coin changing...
    // -----------------------------------------------------------------------------

    /**
     * Given a list of possible coins that must include a penny,
     * and a number of pennies 'n', in how many ways can we use the
     * coins to make change for 'n'.
     */
    static int coinChange (List<Coin> coins, int n) {
        try {
            if (n < 0) return 0; // no way to make change
            else if (n == 0) return 1; // previous choices succeeded
            else return coinChange(coins.getRest(), n) +
                        coinChange(coins,n - coins.getFirst().getValue());
        }
        catch (EmptyListE e) {
            return 0; // no way to make change
        }
    }

    /**
     * Again we create a hash table making sure it is called
     * coinChangeMemo. But here we have to think a bit. Each
     * subproblem is determined by the list of coins and by the
     * desired sum.  That combination should be the key used
     * in hashing.
     */
    static Map<Pair<List<Coin>,Integer>,Integer> coinChangeMemo = new WeakHashMap<>();

    /**
     * We again want to use computeIfAbsent. When we communicate with
     * the hash table, we combine all the information into a key and
     * take back apart when we extract from the hash table.
     */
    static int mcoinChange (List<Coin> coins1, int n1) {
        return coinChangeMemo.computeIfAbsent(new Pair<>(coins1,n1), p -> {
            List<Coin> coins = p.getFirst();
            int n = p.getSecond();
            try {
                if (n < 0) return 0; // no way to make change
                else if (n == 0) return 1; // previous choices succeeded
                else return mcoinChange(coins.getRest(), n) +
                            mcoinChange(coins, n - coins.getFirst().getValue());
            }
            catch (EmptyListE e) {
                return 0; // no way to make change
            }
        });
    }

    // -----------------------------------------------------------------------------
    // Partition ...
    // -----------------------------------------------------------------------------

    /**
     * Partition: take a list, a desired sum 's', and return
     * T/F depending on whether it is possible to find a
     * subsequence of the list whose sum is exactly 's'
     */
    static boolean partition (List<Integer> s, int sum) {
        try {
            
            int first = s.getFirst();

            return partition(s.getRest(), sum - first) || partition(s.getRest(), sum);
        } catch (EmptyListE e) {
            return (sum == 0);
        }
    }
    static Map<Pair<List<Integer>,Integer>,Boolean> partitionMemo = new WeakHashMap<>();
    static boolean mpartition (List<Integer> s1, int sum1) {
        return partitionMemo.computeIfAbsent(new Pair<>(s1, sum1), p -> {
            List<Integer> li = p.getFirst();
            int sum = p.getSecond();
            try {

                int first = li.getFirst();

                return mpartition(li.getRest(), sum - first) || (mpartition(li.getRest(), sum));
            }
            catch (Exception e) {
                return (sum == 0);
            }
        });
    }

    // -----------------------------------------------------------------------------
    // Min distance ...
    // -----------------------------------------------------------------------------

    final static int GAP = 2;
    final static int MATCH = 0;
    final static int MISMATCH = 1;

    enum BASE { A, T, G, C }

    static int minDistance (List<BASE> dna1, List<BASE> dna2) {
        try {
            if (dna1.isEmpty() && !(dna2.isEmpty())) {
                return GAP * dna2.length();
            } else if (dna2.isEmpty() && !(dna1.isEmpty())) {
                return GAP * dna1.length();
            }
            if (dna2.isEmpty() && dna1.isEmpty()) {
                return MATCH;
            }
            if (dna1.getFirst() == dna2.getFirst()) {
                return MATCH + minDistance(dna1.getRest(), dna2.getRest());
            }
            int i1 = minDistance(dna1.getRest(), dna2.getRest()) + MISMATCH;
            int i2 = minDistance(dna1.getRest(), dna2) + GAP;
            int i3 = minDistance(dna1, dna2.getRest()) + GAP;
            return (Math.min(Math.min(i1, i2), i3));
        }
        catch (EmptyListE e) {
            return 0;
        }
    }

    static Map<Pair<List<BASE>, List<BASE>>, Integer> minDistanceMemo = new WeakHashMap<>();

    static int mminDistance (List<BASE> dna11, List<BASE> dna21) {
        return minDistanceMemo.computeIfAbsent(new Pair<>(dna11, dna21), p -> {
            List<BASE> dna1 = p.getFirst();
            List<BASE> dna2 = p.getSecond();
            try {
                if (dna1.isEmpty() && !(dna2.isEmpty())) {
                    return GAP * dna2.length();
                }
                if (dna2.isEmpty() && !(dna1.isEmpty())) {
                    return GAP * dna1.length();
                }
                if (dna2.isEmpty() && dna1.isEmpty()) {
                    return MATCH;
                }
                if (dna1.getFirst() == dna2.getFirst()) {
                    return MATCH + mminDistance(dna1.getRest(), dna2.getRest());
                }
                int i3 = mminDistance(dna1, dna2.getRest()) + GAP;
                int i2 = mminDistance(dna1.getRest(), dna2) + GAP;
                int i1 = mminDistance(dna1.getRest(), dna2.getRest()) + MISMATCH;
                return (Math.min(Math.min(i1, i2), i3));
            }
            catch (EmptyListE e) {
                return 0;
            }
        });
    }

    // -----------------------------------------------------------------------------
    // Longest common subsequence ...
    // -----------------------------------------------------------------------------

    static List<Character> lcs (List<Character> cs1, List<Character> cs2) {
        try {
            if (cs1.getFirst() == cs2.getFirst()) {
                return new Node<>(cs1.getFirst(), lcs(cs1.getRest(), cs2.getRest()));
            }

            List<Character> res1 = lcs(cs1, cs2.getRest());
            List<Character> res2 = lcs(cs1.getRest(), cs2);

            return longest(res2, res1);

        } catch (EmptyListE e) {
            return new Empty<>();
        }
    }
    static List<Character> longest(List<Character> l1, List<Character> l2) {
        if (l1.length() >= l2.length()) {
            return l1;
        }
        else return l2;
    }
    static Map<Pair<List<Character>, List<Character>>, List<Character>> lcsMemo = new WeakHashMap<>();

    static List<Character> mlcs (List<Character> cs11, List<Character> cs21) {
        return lcsMemo.computeIfAbsent(new Pair<>(cs11,cs21), p -> {
            List<Character> cs1 = p.getFirst();
            List<Character> cs2 = p.getSecond();
            try {
                if (cs1.getFirst() == cs2.getFirst()) {
                    return new Node<>(cs1.getFirst(), mlcs(cs1.getRest(), cs2.getRest()));
                }

                List<Character> res2 = mlcs(cs1, cs2.getRest());
                List<Character> res1 = mlcs(cs1.getRest(), cs2);

                return longest(res1, res2);

            } catch (EmptyListE e) {
                return new Empty<>();
            }
        });
    }
}
