import javax.print.DocFlavor;
import java.math.BigInteger;
import java.util.function.Function;
import java.util.*;

// -------------------------------------------------------

abstract class HashFunction implements Function<Integer,Integer> {}

// -------------------------------------------------------

/**
 *
 * An instance of this class is created with a parameter 'bound'. Then
 * every time the hash function is applied to an argument 'x', it
 * returns the value of 'x' modulo the 'bound'. See the test cases in
 * HashFunctionTest for some examples.
 *
 */
class HashMod extends HashFunction {
    int bound;
    HashMod(int bound) {
        this.bound = bound;
    }
    public Integer apply(Integer x) {
        return x % this.bound;
    }
}
// -------------------------------------------------------

/**
 *
 * An instance of this class is created with two paramters: a first
 * argument 'bound' that is used to create an instance of the
 * superclass, and a second argument 'after' of type
 * Function<Integer,Integer> that is used as follows. When the hash
 * function is invoked, the basic functionality of the super class is
 * first invoked, and then that result is given to the function
 * 'after'. See the test cases in HashFunctionTest for some examples.
 *
 */
class HashModThen extends HashMod {
    Integer bound;
    Function<Integer, Integer> after;
    HashModThen(Integer bound, Function<Integer,Integer> after) {
        super(bound);
        this.bound = bound;
        this.after = after;
    }
}

// -------------------------------------------------------

/**
 *
 * An instance of this class is created with three parameters: a
 * random number generator 'r' of type Random and two integers 'p' and
 * 'm' where 'p' should be a prime number greater than or equal to
 * 'm'. Using the random number generator, the constructor generates
 * two random numbers 'a' and 'b' such that 'a' is in the range 1
 * (inclusive) and p (exclusive) and 'b' is in the range 0 (inclusive)
 * and p (exclusive). The resulting hash function should be a
 * universal hash function as explained in the book. Again see the
 * test cases in HashFunctionTest for some examples.
 *
 */
class HashUniversal extends HashFunction {
    private Random r;
    private Integer p;
    private Integer m;
    HashUniversal(Random r, Integer p, Integer m) {
        this.r = r;
        this.p = p;
        this.m = m;
    }
    public Integer apply(Integer x) {
        int a = r.nextInt(p) + 1;
        int b = r.nextInt(p);
        return ((((a * x) + b) % p) % m);
    }
}

// -------------------------------------------------------
// -------------------------------------------------------
