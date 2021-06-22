
import org.junit.Test;

import java.util.Random;

import static org.junit.Assert.*;

public class TreeTest {

    @Test
    public void emptytree () {
        Random r = new Random();
        Tree<Integer> t1 = Tree.makeTreeNodes(0,2, r, 10);
        assertEquals(2, t1.getBranchingFactor());
        assertEquals(0, t1.getHeight());
        assertEquals(0, t1.getNumberOfNodes());
        assertTrue(t1.isEmpty());
        assertFalse(t1.isLeaf());
        assertEquals(0, t1.numberOfInternalNodes());
        assertEquals(0, t1.numberOfLeaves());
    }

    @Test
    public void leaf () {
        Random r = new Random();
        Tree<Integer> t1 = Tree.makeLeaf(5, 8);
        assertEquals(8, t1.getBranchingFactor());
        assertEquals(1, t1.getHeight());
        assertEquals(1, t1.getNumberOfNodes());
        assertFalse(t1.isEmpty());
        assertTrue(t1.isLeaf());
        assertEquals(0, t1.numberOfInternalNodes());
        assertEquals(1, t1.numberOfLeaves());
    }


    @Test
    public void tree1 () {
        Random r = new Random();
        Tree<Integer> t1;

        t1 = Tree.makeTreeNodes(1+3+9+27,3,r,10);
        assertEquals(3, t1.getBranchingFactor());
        assertEquals(4, t1.getHeight());
        assertEquals(40, t1.getNumberOfNodes());
        assertFalse(t1.isEmpty());
        assertFalse(t1.isLeaf());
        assertEquals(13, t1.numberOfInternalNodes());
        assertEquals(27, t1.numberOfLeaves());

        t1 = Tree.makeTreeInternals(13,3,r,10);
        assertEquals(3, t1.getBranchingFactor());
        assertEquals(4, t1.getHeight());
        assertEquals(40, t1.getNumberOfNodes());
        assertFalse(t1.isEmpty());
        assertFalse(t1.isLeaf());
        assertEquals(13, t1.numberOfInternalNodes());
        assertEquals(27, t1.numberOfLeaves());

        t1 = Tree.makeTreeLeaves(27,3,r,10);
        assertEquals(3, t1.getBranchingFactor());
        assertEquals(4, t1.getHeight());
        assertEquals(40, t1.getNumberOfNodes());
        assertFalse(t1.isEmpty());
        assertFalse(t1.isLeaf());
        assertEquals(13, t1.numberOfInternalNodes());
        assertEquals(27, t1.numberOfLeaves());

    }

}
