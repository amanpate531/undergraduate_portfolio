public class Test {
  public static void main(String[] args) {
  }
  public ArrayList read (){

          File text = new File("processes1.txt");

              ArrayList<String> tokens = new ArrayList<String>();

              Scanner tokenize;
            try {
                tokenize = new Scanner(text);
                while (tokenize.hasNext()) {

                      tokens.add(tokenize.next());
                  }

                }

            catch(IOException ioe){
                ArrayList<String> nothing = new ArrayList<String>();
                nothing.add("error1");
                System.out.println("error");
                //return nothing;
              }
             return tokens;

    }}