package Problems;

//import java.io.Serializable;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Inbox;
import akka.actor.Props;
import akka.actor.UntypedActor;
import akka.pattern.Patterns;
import akka.util.Timeout;
import scala.concurrent.Await;
import scala.concurrent.Future;
import scala.concurrent.duration.Duration;

public class Problem1 {
	// Define static classes for any actors that will be needed
	private static class fiboActor extends UntypedActor{
		public void onReceive(Object message){
			// Check what kind of message we received
			if(message instanceof Long){
				// Accept Long integer nthFibo
				Long nthFibo = (Long) message;
			
				Long result = new Long(0);
				// Base cases when nthFibo = 0, 1, 2
				if(nthFibo <= 0){
					result = new Long(0);
				}else if(nthFibo <= 2){
					result = new Long(1);
				}
				else {					
					final ActorRef childWorker1 = getContext().actorOf(Props.create(fiboActor.class));
					final ActorRef childWorker2 = getContext().actorOf(Props.create(fiboActor.class));
					
					Timeout t = new Timeout(Duration.create(20, TimeUnit.SECONDS));
					
					Future<Object> future1 = Patterns.ask(childWorker1, new Long(nthFibo-1), t);
					Future<Object> future2 = Patterns.ask(childWorker2, new Long(nthFibo-2), t);

					Long r1 = null;
					Long r2 = null;
					// Get result from children
					try {
						r1 = (Long) Await.result(future1, t.duration());
						r2 = (Long) Await.result(future2, t.duration());
					} catch (Exception e) {
						System.out.println("Got a timeout after waiting 20 seconds for the value of " + (nthFibo - 1)
								+ "! from a child worker");
						System.exit(1);
					}
					result = new Long(result + r1 + r2);
				}
				getSender().tell(result, getSelf());
			}
			else{
				unhandled(message);
			}
		}
	}
	public static void main(String[] args) {

		// Prompt the user for an integer
		System.out.println("Note: 20! is the largest Fibonacci number which can be represented by a Long integer");
		System.out.print("Please enter value of n for which to calculate the nth Fibonacci number: ");
		Scanner in = new Scanner(System.in);
		Long num = new Long(in.nextInt());
		in.close();

		// Create an actor system
		final ActorSystem actorSystem = ActorSystem.create("actor-system");

		// Create a worker actor
		final ActorRef worker = actorSystem.actorOf(Props.create(fiboActor.class), "fiboActor");

		// Create an inbox
		final Inbox inbox = Inbox.create(actorSystem);

		// Tell the worker to calculate the numth Fibonacci number
		inbox.send(worker, num);

		// Wait up to 20 seconds for a reply from the worker
		Long reply = null;
		try {
			reply = (Long) inbox.receive(Duration.create(20, TimeUnit.SECONDS));
		} catch (TimeoutException e) {
			System.out.println("Got a timeout after waiting 20 seconds for the value of " + num + "!");
			System.exit(1);
		}

		// Print the reply received
		System.out.println(num + "th Fibonacci number is " + reply);

		// Shut down the system gracefully
		actorSystem.terminate();

	}

}
