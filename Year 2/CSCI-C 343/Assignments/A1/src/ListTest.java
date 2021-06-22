import static org.junit.Assert.*;
import org.junit.Test;

public class ListTest {

    @Test
    public void length () {
        List vs = new Empty();
        List ws = new Node(2, new Node(3, new Node(5, new Node(7, new Node(11, new Node(13, new Empty()))))));
        List xs = new Node(1,new Node(2, new Node (3, new Empty())));
        assertEquals(3, xs.length());
        assertEquals(0, vs.length());
        assertEquals(6, ws.length());
    }

    @Test
    public void append () {
        List vs = new Empty();
        List ws = new Node(4, new Node(5, new Node(4, new Node(5, new Empty()))));
        List xs = new Node(1,new Node(2, new Node(3, new Empty())));
        List ys = new Node(4, new Node (5, new Empty()));
        List zs = new Node(1,new Node(2, new Node(3, new Node(4, new Node(5, new Empty())))));
        assertEquals(zs, xs.append(ys));
        assertEquals(ws, ys.append(ys));
        assertEquals(zs, zs.append(vs));
    }

    @Test
    public void isEmpty () {
        List xs = new Empty();
        List ys = new Node(2, new Empty());
        List zs = new Node(1,new Node(2, new Node(3, new Node(4, new Node(5, new Empty())))));
        assertTrue(xs.isEmpty());
        assertTrue(!(ys.isEmpty()));
        assertTrue(!(zs.isEmpty()));
    }

    @Test
    public void total () {
        List xs = new Node(1, new Node(2, new Node(3, new Empty())));
        List ys = new Empty();
        List zs = new Node(1,new Node(2, new Node(3, new Node(4, new Node(5, new Empty())))));
        assertEquals(0, ys.total());
        assertEquals(6, xs.total());
        assertEquals(15, zs.total());
    }

    @Test
    public void square () {
        List xs = new Node(1, new Node(2, new Node(3, new Empty())));
        List ys = new Empty();
        List zs = new Node(1, new Node(4, new Node(9, new Empty())));
        assertEquals(zs, xs.square());
        assertEquals(ys,ys.square());
    }

    @Test
    public void product () {
        List xs = new Node(1, new Node(2, new Node(3, new Empty())));
        List ys = new Empty();
        List zs = new Node(1, new Node(4, new Node(9, new Empty())));
        assertEquals(1, ys.product());
        assertEquals(36, zs.product());
        assertEquals(6, xs.product());
    }

    @Test
    public void allEven () {
        List ws = new Node(2, new Node(4, new Node(6, new Node(22, new Empty()))));
        List xs = new Node(1, new Node(2, new Node(3, new Empty())));
        List ys = new Empty();
        List zs = new Node(1, new Node(4, new Node(9, new Empty())));
        assertTrue(ws.allEven());
        assertTrue(!(xs.allEven()));
        assertTrue(ys.allEven());
        assertTrue(!(zs.allEven()));
    }

    @Test
    public void evens () {
        List ws = new Node(2, new Node(4, new Node(6, new Node(22, new Empty()))));
        List xs = new Node(1, new Node(2, new Node(3, new Empty())));
        List ys = new Empty();
        List zs = new Node(2, new Empty());
        assertEquals(ws, ws.evens());
        assertEquals(zs, xs.evens());
        assertEquals(ys, ys.evens());
    }

    @Test
    public void triplicate () {
        List vs = new Node(3, new Empty());
        List ws = new Node(3, new Node(3, new Node(3, new Empty())));
        List xs = new Node(2, new Node(2, new Node(2, new Node(1, new Node(1, new Node (1, new Empty()))))));
        List ys = new Empty();
        List zs = new Node(2, new Node(1, new Empty()));
        assertEquals(ws, vs.triplicate());
        assertEquals(ys, ys.triplicate());
        assertEquals(xs, zs.triplicate());
    }
}