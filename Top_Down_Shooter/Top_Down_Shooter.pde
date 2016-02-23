
//Brendan Leder      22:38:17 May 21 2015

//Top Down Shooter Game - "Zombie Arena"

//A top down shooter style game that features
//a single player that has to fight using 3
//weapons against increasingly powerful waves
//of variably powerful zombies
/*
Ideas:
 3D
 Hair
 Controller: When release controller stay at location
 */

import processing.sound.*;
boolean controller = false;
import processing.serial.*;
Serial myPort;
boolean soundon = false;
Game g;
Player p;
Bullet bullets[] = new Bullet[1000000];
int xBoundary = 200;
int yBoundary = 200;
Wall walls[] = new Wall[40 + int((xBoundary+yBoundary)/8)];
Weapons w;
Pickup pick;
Zombie z[] = new Zombie[100];
boolean pause;
float distance;
float accuracy;
PVector looking;
SoundFile gunshot;
SoundFile knife;
PFont titlefont;
float wi;
float h;
boolean run;
int title;
PFont zFont;
float X1;
float Y1;
int R31; //left
float X2;
float Y2;
int R32;
int trigL = 1;
int trigR = 1;
boolean trigPulled = false;
boolean trigPulled2 = false;
boolean ran = false;

void setup() {
  lights();
  if (controller == true) {
    String portName = Serial.list()[2];
    if (ran == false) {
      myPort = new Serial(this, portName, 9600);
    }
    myPort.bufferUntil('\n');
  }
  smooth();
  size(1280, 750, P3D);
  zFont = createFont("Courier Bold", 10);
  run = false;
  wi = width;
  h = height;
  title = int(random(8));
  title = -1;
  titlefont = createFont("ArnoPro-Bold", 200);

  g = new Game();

  looking = new PVector(0, 0);
  gunshot = new SoundFile(this, "gunshot.mp3");
  knife = new SoundFile(this, "knife.mp3");

  p = new Player(width/2, height/2);
  w = new Weapons();
  pick = new Pickup();

  g.gsetup();
}

void draw() {

  /*
  myPort.write(1);
   
   if(myPort.available() > 0) {
   String positions = (myPort.readStringUntil('\n'));
   String[] numb = (split(positions, ' '));
   X1  = map(float(numb[0]), 511, 0, 0, 100);
   Y1  = map(float(numb[1]), 505, 0, 0, 100);
   R31 = int(numb[2]);
   X2  = map(float(numb[3]), 520, 0, 0, 100);
   Y2  = map(float(numb[4]), 515, 0, 0, 100);
   R32 = int(numb[5]);
   }
   
   println("X: " + X1 + " Y: " + Y1);
   
   println("xR31: " + R31 + " R32: " + R32);
   
   */

  stroke(0);
  if (run == false) {
    background(0);
    textFont(titlefont, 100);
    textAlign(CENTER);
    fill(255);
    rect(wi/2, height-h/2 - 10, wi/4, h/11, 5);
    rect(wi/2, height-h/3 - 10, wi/4, h/11, 5);
    textSize(35);
    if (title != 7) {
      text("By: Brendan Leder", width-wi/7, height-h/21);
    } else {
      text("By: Not Me", width-wi/7, height-h/21);
    }
    textSize(107);
    if (title == -1) {
      text("Zombie Arena", wi/2, h/4);
    } else if (title == 7) {
      text("Legacy of The Gordonger", wi/2, h/4);
    } else if (title == 6) {
      text("They call me Bread", wi/2, h/4);
    } else if (title == 5) {
      text("Arma VI Simulator 2016", wi/2, h/4);
    } else if (title == 4) {
      text("It's Game I Made", wi/2, h/4);
    } else if (title == 3) {
      text("Prepair 4 Disupointmnt", wi/2, h/4);
    } else if (title == 2) {
      text("Bethasta - Eldank Scralls", wi/2, h/4);
    } else if (title == 1) {
      text("Dank Souls-U'll Die Edition", wi/2, h/4);
    } else {
      text("The guy with a gun", wi/2, h/4);
      text("and other stuff as well", wi/2, h/4 + 80);
    }
    pushMatrix();
    translate(-50, 0);
    for (int q = 0; q < 255; q++) {
      stroke(q, 0, 0);
      line(width - 350 + q, height/2, width - 350 + q, height/2-15);
      stroke(0, q, 0);  
      line(width - 350 + q, height/2 + 20, width - 350 + q, height/2+5);
      stroke(0, 0, q);
      line(width - 350 + q, height/2 - 20, width - 350 + q, height/2-35);
    }

    for (int q = 0; q < 255; q++) {
      stroke(q, 0, 0);
      line(width - 350 + q, height/2+ 100, width - 350 + q, height/2-15+ 100);
      stroke(0, q, 0);  
      line(width - 350 + q, height/2 + 20+ 100, width - 350 + q, height/2+5+ 100);
      stroke(0, 0, q);
      line(width - 350 + q, height/2 - 20+ 100, width - 350 + q, height/2-35+ 100);
    }

    stroke(255);

    if (mousePressed && mouseX > width - 400 && mouseX < width - 145) {
      if (mouseY > height/2 -15 + 100&& mouseY < height/2+ 100) {
        p.pr = mouseX - width + 400;
      } else if (mouseY > height/2 + 5 + 100 && mouseY < height/2 + 20+ 100) {
        p.pg = mouseX - width + 400;
      } else if (mouseY > height/2 - 35 + 100 && mouseY < height/2 - 20+ 100) {
        p.pb = mouseX - width + 400;
      }
    }

    if (mousePressed && mouseX > width - 400 && mouseX < width - 145) {
      if (mouseY > height/2 -15 && mouseY < height/2) {
        p.sr = mouseX - width + 400;
      } else if (mouseY > height/2 + 5 && mouseY < height/2 + 20) {
        p.sg = mouseX - width + 400;
      } else if (mouseY > height/2 - 35 && mouseY < height/2 - 20) {
        p.sb = mouseX - width + 400;
      }
    }
    popMatrix();

    fill(p.pr, p.pg, p.pb);
    rect(width-48, h/2+91, 30, 76, 5);
    rect(width-99, h/2+151, 30, 76, 5);
    pushMatrix();
    translate(width-93, h/2+92, -1); //Translate
    rotate(0.2);
    rect(0, 0, 30, 76, 5);
    popMatrix();

    pushMatrix();
    translate(width-36, h/2+158, -1); //Translate
    rotate(-0.4);
    rect(0, 0, 30, 76, 5);
    popMatrix();

    fill(p.sr, p.sg, p.sb);

    pushMatrix();
    translate(width-113, h/2+-28, -1); //Translate
    rotate(0.2);
    rect(0, 0, 20, 66, 5);
    popMatrix();

    pushMatrix();
    translate(width-71, h/2, 1); //Translate
    rotate(-0.1);
    rect(0, 0, 75, 123, 10);
    popMatrix();

    pushMatrix();
    translate(width-36, h/2+-31, 2); //Translate
    rotate(-0.4);
    rect(0, 0, 20, 66, 5);
    popMatrix();

    pushMatrix();
    translate(width-28, h/2+12, 3); //Translate
    rotate(0.1);
    rect(0, 0, 20, 66, 5);
    popMatrix();

    pushMatrix();
    translate(width-140, h/2+25, -3); //Translate
    rotate(0.7);
    rect(0, 0, 20, 66, 5);
    popMatrix();

    fill(210, 200, 150);
    ellipse(width-80, h/2-93, 45, 53);

    stroke(0);
    beginShape();
    curveVertex(width-45, h/2-107);
    curveVertex(width-81, h/2-85);
    curveVertex(width-84, h/2-94);
    curveVertex(width-80, h/2-69);
    endShape();

    fill(10, 100, 140);
    ellipse(width-72, h/2-95, 4, 3);
    line(width-72, h/2-97, width-77, h/2 - 96);
    line(width-72, h/2-97, width-66, h/2 - 96);
    line(width-71, h/2-93, width-65, h/2 - 96);
    line(width-71, h/2-93, width-78, h/2 - 95);

    pushMatrix();
    translate(-22, 0);
    scale(1, 1);
    ellipse(width-72, h/2-95, 4, 3);
    line(width-72, h/2-97, width-77, h/2 - 96);
    line(width-72, h/2-97, width-66, h/2 - 96);
    line(width-71, h/2-93, width-65, h/2 - 96);
    line(width-71, h/2-93, width-78, h/2 - 95);
    popMatrix();

    line(width-90, h/2-76, width-73, h/2 - 77);

    stroke(0);
    fill(0);
    textSize(50);
    text("Start", wi/2, height-h/2);
    text("Quit", wi/2, height-h/3);
    if (mousePressed) {
      if (mouseX < wi/2 + wi/8 && mouseX > wi/2 - wi/8) {
        if (mouseY > height - h/2 - h/22 && mouseY < height - h/2 + h/22) {
          run = true;
        }
        if (mouseY > height - h/3 - h/22 && mouseY < height - h/3 + h/22) {
          exit();
        }
      }
    }
  } else {
    g.gdraw();
  }
}

void keyReleased() {
  if (run == true) {
    g.gkeyReleased();
  }
}

void keyPressed() {
  if (key == '=') {
    title = int(random(8));
  }
  if (run == true) {
    g.gkeyPressed();
  }
}

void mouseReleased() {
  if (run == true) {
    g.gmouseReleased();
  }
}

void serialEvent (Serial myPort) {

  String positions = (myPort.readStringUntil('\n'));
  String[] numb = (split(positions, ' '));
  X1  = map(float(numb[0]), 511, 0, 0, -100);
  Y1  = map(float(numb[1]), 505, 0, 0, -100);



  R32 = int(numb[2]);

  float tempX2  = map(float(numb[3]), 520, 0, 0, -100);
  float tempY2  = map(float(numb[4]), 515, 0, 0, -100);

  if (tempY2 != 0.19417477 && tempY2 != 0.38834953 && tempY2 != 0) {
    Y2  = map(float(numb[4]), 515, 0, 0, -100);
  }
  if (tempX2 != 0.1923077 && tempX2 != 0) {
    X2  = map(float(numb[3]), 520, 0, 0, -100);
  }



  if (Y1==0.1980198) {
    Y1 = 0;
  }
  if (X1==0.19569471) {
    X1 = 0;
  }
  /*
  if (Y2==0.19417477 || Y2==0.38834953) {
   Y2 = 0;
   }
   if (X2==0.1923077) {
   X2 = 0;
   }
   */

  R31 = int(numb[5]);
  trigL = int(numb[6]);
  trigR = int(numb[7]);
}