import processing.serial.*;
import controlP5.*;
ControlP5 cp5;
PFont font;
Serial myPort;
PImage logo;

int denaturingTemp;
int annealingTemp;
int extendingTemp;
int denaturingTimeRaw;
int annealingTimeRaw;
int extendingTimeRaw;
int numCycles;
String touchdownStart;
String touchdownEnd;
String touchdownCycles;
int cycleTime;
boolean touchdown = false;
boolean submitted = false;
  
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


void makePlan(){
  int currxpos = 50;
  
  // set to denaturingTemp for denaturingTime
  
  // set to annealingTemp for annealingTime (TODO touchdown)
  
  // set to extendingTemp for extendingTime
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
  image(logo, 725, 40, width/6, height/6);
  line(0, 350, 800, 350);
  //makeGUI();
  
  strokeWeight(1);
  // make graph
  line(50,650, 400,650);
  line(50,650, 50,450);
  line(400,650,400,450);
  for (int i = 650; i >= 450; i-=25){
      line(50,i, 400,i);
      if (((200 - (i - 450))/2) % 25 == 0){
        //line(45, i, 50, i);
        textSize(10);
        fill(0);
        text((200 - (i - 450))/2, 30, i+5);
      }
  }
  
  if (submitted){
    // 50 to 400
    // calculate x
    float denaturingXPct = float(denaturingTimeRaw)/float(cycleTime);
    float annealingXPct = float(annealingTimeRaw)/float(cycleTime);
    float extendingXPct = float(extendingTimeRaw)/float(cycleTime);
    float denaturingSpc = denaturingXPct * 350;
    float annealingSpc = annealingXPct * 350;
    float extendingSpc = extendingXPct * 350;    
    
    // 650 to 450
    //calculate y
    float denaturingY = (100 - denaturingTemp)*2 + 450;    
    float annealingY = (100 - annealingTemp)*2 + 450;
    float extendingY = (100 - extendingTemp)*2 + 450;
    
    //stroke(255, 0, 0);
    strokeWeight(2);
    //denaturing
    line(50, denaturingY, 50 + denaturingSpc, denaturingY);
      //ramp down
    line(50+denaturingSpc, denaturingY, 50+denaturingSpc, annealingY);
    //annealing
    line(50 + denaturingSpc, annealingY, 50 + denaturingSpc + annealingSpc, annealingY);
      // ramp up
    line(50+denaturingSpc + annealingSpc, annealingY, 50+denaturingSpc + annealingSpc, extendingY);      
    //extending
    line(50 + denaturingSpc + annealingSpc, extendingY, 50 + denaturingSpc + annealingSpc + extendingSpc, extendingY);
    
    // set back to black
    stroke(0);
  }
  //cp5.controller.setVisible(false);
  
  
}


void makeGUI(){
  // hardcoding placement because no one should be changing this
  
  cp5.addTextlabel("SETUP").setText("SETUP")
      .setPosition(20,20).setColorValue(0)
      .setFont(createFont("Georgia", 25));
      
  cp5.addTextlabel("RUNTIME").setText("RUNTIME")
      .setPosition(20,370).setColorValue(0)
      .setFont(createFont("Georgia", 25));
      
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
      
  cp5.addTextlabel("touchdown").setText("Or touchdown from")
      .setPosition(400,150).setColorValue(0).setFont(font);  
 
  cp5.addTextlabel("touchdown2").setText("to")
      .setPosition(575,150).setColorValue(0).setFont(font);  
  
  cp5.addTextlabel("touchdown3").setText("for")
      .setPosition(630,150).setColorValue(0).setFont(font); 
  cp5.addTextlabel("touchdown4").setText("cycles")
      .setPosition(690,150).setColorValue(0).setFont(font);  
      
  if (submitted == false){    
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
  
  cp5.addTextfield("touchdownStart").setPosition(540, 150).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);     
  cp5.addTextfield("touchdownEnd").setPosition(600, 150).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false);  

  cp5.addTextfield("touchdownCycles").setPosition(660, 150).setSize(30, 30)
        .setFont(font).setFocus(true).setColor(color(255,255,255))
            .setAutoClear(false); 

  }
  // .setVisible(false) after input 
  cp5.addButton("Submit").setPosition(225,300);  
  
//  image(logo, 300,300);
}


void Submit() {
  submitted = true;
  denaturingTemp = int(cp5.get(Textfield.class,"denaturingTemp").getText());
  annealingTemp = int(cp5.get(Textfield.class,"annealingTemp").getText());
  extendingTemp = int(cp5.get(Textfield.class,"extendingTemp").getText());
  denaturingTimeRaw = int(cp5.get(Textfield.class,"denaturingTime").getText());
  annealingTimeRaw = int(cp5.get(Textfield.class,"annealingTime").getText());
  extendingTimeRaw = int(cp5.get(Textfield.class,"extendingTime").getText());
  
  touchdownStart =  cp5.get(Textfield.class,"touchdownStart").getText();
  touchdownEnd = cp5.get(Textfield.class,"touchdownEnd").getText();
  touchdownCycles = cp5.get(Textfield.class,"touchdownCycles").getText();
  
  numCycles = int(cp5.get(Textfield.class,"numCycles").getText());
  cycleTime = denaturingTimeRaw + annealingTimeRaw + extendingTimeRaw;
  
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
    touchdown = true;    //pass this through to arduino
   setup[3] = "Annealing Temp: touchdown from " + touchdownStart + " to " + touchdownEnd; 
  }
  saveStrings(filename, setup); 
}