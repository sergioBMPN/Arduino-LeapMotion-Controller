import de.voidplus.leapmotion.*;
import processing.serial.*;

// ======================================================
// Table of Contents:
// ├─ 1. Swipe Gesture
// ├─ 2. Circle Gesture
// ├─ 3. Screen Tap Gesture
// └─ 4. Key Tap Gesture
// ======================================================


LeapMotion leap;
Serial myPort;  // Create object from Serial class
int Aizq=-1;
int Adch=-1;

void setup(){
  size(800, 500);
  background(255);
  // ...
  
  leap = new LeapMotion(this);//.allowGestures("swipe");  // Leap detects only swipe gestures
  //ArrayList ports = new ArrayList<String>();
  //ports=Serial.list();
  //if(length()>0)

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw(){
  background(255);
  // ...
  ///*
  
    ArrayList hands = new ArrayList<Hand>();
    if(leap.getHands()!=null){
      hands = leap.getHands();
    }
    if(hands.size()==2){
    
    for (Hand hand : leap.getHands ()) {     
      hand.draw();
      
      if(hand.isLeft()){
        if(hand.getGrabStrength()>=0.7){ 
          println("Acelera Izq");
          Aizq=1;
        }
        else {
           println("Frena Izq");
           Aizq=0;
        }
      }
      if(hand.isRight()){
        if(hand.getGrabStrength()>=0.7){
          println("Acelera Der");
          Adch=1;
        }
        else {
           println("Frena Der");
           Adch=0;
        }
      }      
    }
  }
   else
   {
     Adch=-1; 
     Aizq=-1;
   }
      HandController();
}

void HandController()
{
  if(Aizq==1 && Adch==1){
    myPort.write('w'); 
  }
  else if(Aizq==0 && Adch==0){
    myPort.write('s'); 
  }
  else if(Aizq==1 && Adch==0){
    myPort.write('a'); 
  }
  else if(Aizq==0 && Adch==1){
    myPort.write('d'); 
  }
  else{
    myPort.write('F'); 
  }
}

void keyPressed() //Cuando se pulsa una tecla
{
  if(key=='w'||key=='W')
  {
    myPort.write('w'); 
  }
  else if(key=='s'||key=='S')
  {
    myPort.write('s'); 
  }
  else if(key=='a'||key=='A')
  {
    myPort.write('a'); 
  }
  else if(key=='d'||key=='D')
  {
    myPort.write('d'); 
  }
  //Pulsar la tecla E para salir del programa
  else
  {
    myPort.write('F'); // Escribe los datos restantes en el archivo
  }

}