import de.voidplus.leapmotion.*;
import processing.serial.*;

LeapMotion leap;
Serial myPort;  // Create object from Serial class
String portName; // Puerto de conexion al coche

int Left_go; // Aceleracion de la rueda izquierda
int Right_go; // Aceleracion de la rueda derecha

void setup(){
  size(800, 500);
  background(255);
  // ...   
  
  leap = new LeapMotion(this); // Instancia de LeapMotion
 
  portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  Right_go=-1;
  Left_go=-1;
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
          Left_go=1;
        }
        else {
           println("Frena Izq");
           Left_go=0;
        }
      }
      if(hand.isRight()){
        if(hand.getGrabStrength()>=0.7){
          println("Acelera Der");
          Right_go=1;
        }
        else {
           println("Frena Der");
           Right_go=0;
        }
      }      
    }
  }
   else
   {
     Right_go=-1; 
     Left_go=-1;
   }
      HandController();
}

void HandController()
{
  if(Left_go==1 && Right_go==1){
    myPort.write('w'); 
  }
  else if(Left_go==0 && Right_go==0){
    myPort.write('s'); 
  }
  else if(Left_go==1 && Right_go==0){
    myPort.write('a'); 
  }
  else if(Left_go==0 && Right_go==1){
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
  else if(key=='d'||key=='D')
  {
    println("luces");
    myPort.write('l'); 
    
  }
  else
  {
    myPort.write('F'); // Escribe los datos restantes en el archivo
  }

}