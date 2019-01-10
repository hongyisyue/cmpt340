/* File Name: Tutorial8Solution.java
 Author: David Kreiser
 Adapted from basic Akka tutorial at http://akka.io/
 Class: CMPT 340 Tutorial 8
 Contents: Basic file structure for Tutorial 8 example
 */

package simple;


import akka.actor.UntypedActor;
import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Props;

/* Imports go here */



/* End of imports  */


// One class contains entire program - sufficient for our purposes. Could be split into different files.
public class Tutorial8Simple {
    
    public void onReceive(Object message) throws Exception {
    if (message instanceof setGreeting) {
    this.greeting = "Hello" +((SetGreeting))message.who +"!";
    }
    else if(message instanceof Greeting){
    setSender().tell(new Greeeting(greeting).getSelf());
    }
    else{
    unhandled(message);
    }
    }
    
    private static class setGreeting
    private static class Greeting implements Serializable{
    public String message;
    
    public Greeting(String m){
    this.message = m;
    }
    }
    // Define static classes for any actors that will be needed
    
    
    // Define static classes for each type of message we are going to be passing
    
    
    public static void main(String[] args) {
    final ActorSystem actorSyatem = ActorSystem.create("actor-system");
    
    // Create an actor system
    final ActorRef = greeter = actorSystem.actorOf()
    // Create a greeter actor
    
    
    // Create an inbox (actor in a box), allows our main function to send
    // and receive messages without being an actor itself
    
    
    // Set the actor's greeting message
    
    
    // Ask the greeter for a greeting message
    
    
    // Wait up to 5 seconds for a reply from the greeter
    
    
    // Print the reply received
    
    
    // Shut down the system
    
    
    }
    
}