import org.junit.Test;

import java.util.Random;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class HashTableTest {

    @Test
    public void fig55 () throws TableFullE {
        HashFunction hf = new HashMod(10);
        HashTable ht = new HashSeparateChaining(10, hf);
        ht.insert(0);
        ht.insert(81);
        ht.insert(64);
        ht.insert(49);
        ht.insert(9);
        ht.insert(36);
        ht.insert(25);
        ht.insert(16);
        ht.insert(4);
        ht.insert(1);
        System.out.println("Fig. 5.5");
        System.out.println(ht);
    }

    @Test
    public void fig511 () throws TableFullE {
        HashFunction hf = new HashMod(10);
        HashTable ht = new HashLinearProbing(10, hf);
        ht.insert(89);
        ht.insert(18);
        ht.insert(49);
        ht.insert(58);
        ht.insert(69);
        System.out.println("Fig. 5.11");
        System.out.println(ht);
    }

    @Test
    public void fig513 () throws TableFullE {
        HashFunction hf = new HashMod(10);
        HashTable ht = new HashQuadProbing (10, hf);
        ht.insert(89);
        ht.insert(18);
        ht.insert(49);
        ht.insert(58);
        ht.insert(69);
        System.out.println("Fig. 5.13");
        System.out.println(ht);
    }

    @Test
    public void fig518 () throws TableFullE {
        HashFunction hf = new HashMod(10);
        HashFunction hf2 = new HashModThen(7, h -> 7 - h);
        HashTable ht = new HashDouble (10, hf, hf2);
        ht.insert(89);
        ht.insert(18);
        ht.insert(49);
        ht.insert(58);
        ht.insert(69);
        System.out.println("Fig. 5.18");
        System.out.println(ht);
    }

}
