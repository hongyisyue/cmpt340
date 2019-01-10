package Problems;
//import java.util.Random;
/**
import java.io.Serializable;
import java.util.concurrent.TimeUnit;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
*/
import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Inbox;
import akka.actor.Props;
import akka.actor.UntypedActor;
/**
import akka.pattern.Patterns;
import akka.util.Timeout;
import scala.concurrent.Await;
import scala.concurrent.Future;
import scala.concurrent.duration.Duration;
*/

public class Problem2 {
			// Time it takes a man to proposal in milliseconds
			//private static final int TIME_TO_PROPOSAL = 2000;

			// Maximum time in seconds a man will wait before asking the woman again
			// for permission to marry him
			//private static final int MAX_DELAY_DURATION = 10;
			
			//the number of couples so far
			private static int numOfCouples = 0;
			
			// A human can either be single or married
			private enum State {
				SINGLE, MARRIED
			};
			
			// ManActors defined here
			public static class ManActor extends UntypedActor {
				//the list of prefer woman
				ActorRef[] preferList;
				// the current matching spouse
				ActorRef currentSpouse;

				State state = State.SINGLE;
				
				int counter = 0;
				
				public void preStart(ActorRef[] spouses) {
					
					this.preferList= spouses;					
					currentSpouse = null;
				}			
				// Handles messages received from the woman
				public void onReceive(Object message) throws InterruptedException {
					//pass in the prefer list of woman to man actor
					if (message instanceof ActorRef[]){
						ActorRef[] mind = (ActorRef[]) message;
						
						preferList = mind;
					}
					// start pairing
					if (message instanceof String) {
						String reply = (String) message;
						
						if (reply == "START"){					
							preStart(preferList);
							sendProposal(counter);
						}
						else if (reply == "YES") {							
							
							if (state == State.SINGLE) {
								this.currentSpouse = getSender();
								state = State.MARRIED;							
							}else{
								throw new InterruptedException(" man should only be single when they send proposal ");
							}
							
						} 
						else if (reply == "NO") {
							
							if (state == State.SINGLE) {
								counter++;
								sendProposal(counter);
							}else{
							throw new InterruptedException(" man should only be single when they send proposal ");
							}
						}
						else if (reply == "BREAK_UP"){
							currentSpouse = null;
							state = State.SINGLE;
							counter++;
							sendProposal(counter);
						}
					}
					else {
						unhandled(message);
					}

				}
				public void sendProposal(int i){
					if(preferList[i] != null){
						ActorRef currentPref = preferList[i];//get the woman in the list
						//sends proposal message to their current preference
						currentPref.tell("I_LOVE_U", getSelf());
					}
				}
}
			public static class WomanActor extends UntypedActor {
				//the list of prefer man
				ActorRef[] preferList;
				// the current matching spouse
				ActorRef currentSpouse;

				State state = State.SINGLE;
		
				// Handles messages received from cars
				public void onReceive(Object msg) throws InterruptedException{
					//pass in the prefer list of woman to man actor
					if (msg instanceof ActorRef[]){
						ActorRef[] mind = (ActorRef[]) msg;
						
						this.preferList = mind;
						currentSpouse = null;
			
					}
					//start pairing
					if (msg instanceof String) {
						String m = (String) msg;
					
						if (m == "I_LOVE_U") {
								if (state == State.SINGLE) {
									getSender().tell("YES", getSelf());
									state = State.MARRIED;
									this.currentSpouse = getSender();
									numOfCouples++;
									
									System.out.println(getSender().path().name() +" and " + getSelf().path().name() + " are couples now");
								}
								
								else if(state == State.MARRIED){
								//if woman like the new man more than her current spouse, 
								//then send break up message and she has a new husband
								if(getSender().compareTo(currentSpouse) <0){
								this.currentSpouse.tell("BREAK_UP", getSelf());
								System.out.println(currentSpouse.path().name() +" and " + getSelf().path().name() + " break up");
								state = State.SINGLE;
								
								numOfCouples--;
								this.currentSpouse = getSender();
								numOfCouples++;
								
								System.out.println(getSender().path().name() +" and " + getSelf().path().name() + " are repaired couples now");
								}else{
									getSender().tell("NO", getSelf());
								}
							}
								else{
								throw new InterruptedException(" woman should only be either single or married ");
							}						
						}
					} else {
						unhandled(msg);
					}
				}
			}

			//shuffle the array for every man and woman
			public static ActorRef[] shuffleArray(ActorRef[] array)
			  { 
			    for (int i = array.length-1; i > 0; i--)
			    {
			      int index = (int)(Math.random() * (array.length));;
			      // Simple swapBold
			      ActorRef a = array[index];
			      array[index] = array[i];
			      array[i] = a;
			    }
			    return array;
			  }
			
			public static void main(String[] args) {
				ActorSystem system = ActorSystem.create("SingleLaneBridgeProblem");
				// Get a number from the console and generate that many man & woman
			
				int num = 3;
				// Create an inbox
				final Inbox inbox = Inbox.create(system);
				
				//test case that with break up occur
				System.out.println("test case that with break up occur: ");
				
				ActorRef temp1 = system.actorOf(Props.create(ManActor.class), "Man-1");
				ActorRef temp2 = system.actorOf(Props.create(ManActor.class), "Man-2");
				ActorRef temp3 = system.actorOf(Props.create(ManActor.class), "Man-3");
				ActorRef temp4 = system.actorOf(Props.create(ManActor.class), "Man-4");
				
				ActorRef temp11 = system.actorOf(Props.create(WomanActor.class), "Woman-1");
				ActorRef temp22 = system.actorOf(Props.create(WomanActor.class), "Woman-2");
				ActorRef temp33 = system.actorOf(Props.create(WomanActor.class), "Woman-3");
				ActorRef temp44 = system.actorOf(Props.create(WomanActor.class), "Woman-4");
				
				
				ActorRef[] t1 = { temp44, temp11, temp22, temp33};
				ActorRef[] t2 = { temp22, temp33, temp11, temp44};
				ActorRef[] t3 = { temp22, temp44, temp33, temp11};
				ActorRef[] t4 = { temp33, temp11, temp44, temp22};
				
				ActorRef[] t5 = {temp4, temp1, temp3, temp2};
				ActorRef[] t6 = {temp1, temp3, temp2, temp4};
				ActorRef[] t7 = {temp1, temp2, temp3, temp4};
				ActorRef[] t8 = {temp4, temp1, temp3, temp2};

				inbox.send(temp1,t1);
				inbox.send(temp2,t2);
				inbox.send(temp3,t3);
				inbox.send(temp4,t4);
				
				inbox.send(temp11,t5);
				inbox.send(temp22,t6);
				inbox.send(temp33,t7);
				inbox.send(temp44,t8);
				
				inbox.send(temp1, "START");
				inbox.send(temp2, "START");
				inbox.send(temp3, "START");
				inbox.send(temp4, "START");
	
				/**
				//test case that with no break up occur
				System.out.println("test case that with no break up occur: ");
				
				ActorRef[] tt1 = { temp44, temp11, temp22, temp33};
				ActorRef[] tt2 = { temp33, temp22, temp11, temp44};
				ActorRef[] tt3 = { temp22, temp44, temp33, temp11};
				ActorRef[] tt4 = { temp11, temp33, temp44, temp22};
				
				ActorRef[] tt5 = {temp4, temp1, temp3, temp2};
				ActorRef[] tt6 = {temp2, temp3, temp1, temp4};
				ActorRef[] tt7 = {temp3, temp2, temp4, temp1};
				ActorRef[] tt8 = {temp1, temp4, temp2, temp3};

				inbox.send(temp1,tt1);
				inbox.send(temp2,tt2);
				inbox.send(temp3,tt3);
				inbox.send(temp4,tt4);
				
				inbox.send(temp11,tt5);
				inbox.send(temp22,tt6);
				inbox.send(temp33,tt7);
				inbox.send(temp44,tt8);
				
				inbox.send(temp1, "START");
				inbox.send(temp2, "START");
				inbox.send(temp3, "START");
				inbox.send(temp4, "START");
			*/
				if(numOfCouples == num){
					system.terminate();
				}

			}
}
