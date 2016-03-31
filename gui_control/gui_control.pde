import processing.serial.*;
import controlP5.*;
ControlP5 cp5;
PFont font;
Serial myPort;
PImage logo;

String denaturingTemp;
String annealingTemp;
String extendingTemp;
String denaturingTimeRaw;
String annealingTimeRaw;
String extendingTimeRaw;
String numCycles;
String touchdownStart;
String touchdownEnd;
  
void setup(){
  size(800,700);
  logo = loadImage("synbiologo.png");
  
  // set up gui features
  cp5 = new ControlP5(this);
  font = createFont("arial", 15);
  makeGUI();
              
  /*
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 
  */
}


void makeGUI(){
  // hardcoding placement because no one should be changing this
  
   cp5.addTextlabel("SETUP").setText("SETUP")
      .setPosition(20,20).setColorValue(0).setFont(createFont("Georgia", 25));
      
  cp5.addTextlabel("Temp").setText("Temp. (C) : ")
      .setPosition(150,60).setColorValue(0).setFont(font);
  cp5.addTextlabel("Time").setText("Time (sec) : ")
      .setPosition(260,60).setColorValue(0).setFont(font);
  
  cp5.addTextlabel("Denature").setText("Denature: ")
      .setPosition(40,100).setColorValue(0).setFont(font);
  cp5.addTextlabel("Anneal").setText("Anneal: ")
      .setPosition(40,150).setColorValue(0).setFont(font);
  cp5.addTextlabel("Extend").setText("Extend: ")
      .setPosition(40,200).setColorValue(0).setFont(font);
  cp5.addTextlabel("Number of Cycles").setText("Number of Cycles: ")
      .setPosition(40,250).setColorValue(0).setFont(font);      
      
  cp5.addTextfield("denaturingTemp").setPosition(175, 100).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
        .setAutoClear(false);
  cp5.addTextfield("annealingTemp").setPosition(175, 150).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);
  cp5.addTextfield("extendingTemp").setPosition(175, 200).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);  
            
  cp5.addTextfield("denaturingTime").setPosition(300, 100).setSize(60, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
        .setAutoClear(false);
  cp5.addTextfield("annealingTime").setPosition(300, 150).setSize(60, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);
  cp5.addTextfield("extendingTime").setPosition(300, 200).setSize(60, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);//.setColorBackground(#ffffff);          
                      
  cp5.addTextfield("numCycles").setPosition(175, 250).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
        .setAutoClear(false);
        
  cp5.addTextlabel("touchdown").setText("Or touchdown from")
      .setPosition(400,150).setColorValue(0).setFont(font);  
  cp5.addTextfield("touchdownStart").setPosition(540, 150).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);   
  cp5.addTextlabel("touchdown2").setText("to")
      .setPosition(575,150).setColorValue(0).setFont(font);    
  cp5.addTextfield("touchdownEnd").setPosition(600, 150).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);      
        
  cp5.addButton("Submit").setPosition(225,300);
  
//  image(logo, 300,300);

}


void Submit() {
  denaturingTemp = cp5.get(Textfield.class,"denaturingTemp").getText();
  annealingTemp = cp5.get(Textfield.class,"annealingTemp").getText();
  extendingTemp = cp5.get(Textfield.class,"extendingTemp").getText();
  denaturingTimeRaw = cp5.get(Textfield.class,"denaturingTime").getText();
  annealingTimeRaw = cp5.get(Textfield.class,"annealingTime").getText();
  extendingTimeRaw = cp5.get(Textfield.class,"extendingTime").getText();
  
  touchdownStart = cp5.get(Textfield.class,"touchdownStart").getText();
  touchdownEnd = cp5.get(Textfield.class,"touchdownEnd").getText();
  
  numCycles = cp5.get(Textfield.class,"numCycles").getText();
  
  // save this setup to file
  String filename = "../stored_setups/pcr_setup_" + month() + "_" + day() + "_" + year();
  File f = new File(sketchPath(filename));
  if (f.exists()){      // if file already exists, give it time
    filename = filename + "__" + hour() + "_" + minute(); 
  }
  
  String[] setup = {
    "PCR Setup " + month() + "/" + day() + "/" + year() + " " + hour() + ":" + minute(),
    "\n",
    "Denaturing Temp: " + denaturingTemp, 
    "Annealing Temp: " + annealingTemp,
    "Extending Temp: " + extendingTemp,
    "\n",
    "Denaturing Time: " + denaturingTimeRaw,
    "Annealing Time: " + annealingTimeRaw,
    "Extending Time: " + extendingTimeRaw,
    "\n",
    "Number of Cycles: " + numCycles
  };
  if (touchdownStart != ""){
   setup[3] = "Annealing Temp: touchdown from " + touchdownStart + " to " + touchdownEnd; 
  }
  saveStrings(filename, setup); 
}



void draw(){
  /*
  if ( myPort.available() > 0) 
  {  // If data is available,
     val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
//println(val); //print it out in the console
*/

  background(255,255,255);
  imageMode(CENTER);
  image(logo, 550, 30, width/6, height/6);
  //makeGUI();
  
  
}