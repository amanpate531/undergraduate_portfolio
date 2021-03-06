abstract class List {
    abstract int length ();
    abstract boolean isEmpty();
    abstract int total ();
    abstract List append (List ys);
    abstract List square ();
    abstract int product();
    abstract boolean allEven();
    abstract List evens();
    abstract List triplicate();
}
class Empty extends List {
    int length () { return 0; }
    boolean isEmpty () { return true; }
    int total () { return 0; }
    List append (List ys) { return ys; }
    public boolean equals(Object other)
    {return other instanceof Empty;}
    List square() {return new Empty();}
    int product() {return 1;}
    boolean allEven() {return true;}
    List evens() {return new Empty();}
    List triplicate() {return new Empty();}
}
class Node extends List {
    private int data;
    private List rest;
    Node(int data, List rest) {
        this.data = data;
        this.rest = rest;
    }
    int length() {return 1 + rest.length();}
    boolean isEmpty() {return false;}
    int total() {return data + rest.total();}
    List append(List ys) {return new Node(data, rest.append(ys));}
    public boolean equals(Object other){
        if (other instanceof Node){
            Node xs = (Node) other;
            return this.data == xs.data && this.rest.equals(xs.rest);
        }
        else return false;
    }
    boolean allEven() {
        if (this.data % 2 == 0 && this.rest.allEven()) {return true;}
        else return false;
    }
    List evens() {
        if (this.data % 2 == 0) {return new Node(this.data, this.rest.evens());}
        else return this.rest.evens();
    }
    List triplicate() {
        return new Node(this.data, new Node(this.data, new Node(this.data, this.rest.triplicate())));
    }
    int product() {return this.data * this.rest.product();}
    List square() {return new Node(this.data * this.data, this.rest.square());}
}