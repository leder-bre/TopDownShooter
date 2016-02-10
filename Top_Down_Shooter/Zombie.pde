class Zombie {
  int seen;
  int looking;
  float x;
  float y;
  float xspeed;
  float yspeed;
  float xlook;
  float ylook;
  float spotx;
  float spoty;
  PVector movement;
  PVector calc;
  float health = 100;
  int attack = 0;
  int bleeding = 1;
  int r;
  int g;
  int b;
  float size;
  float speed;
  float xsee;
  float ysee;
  int type;
  int dead;
  int bloodx;
  int bloody;

  void spawn() {

    dead = 0;
    bloodx = int(random(-10, 10));
    bloody = int(random(-10, 10));
    size = random(0.9, 1.1);
    speed = ((size-1) * -3) + 1.2;
    calc = new PVector(0, 0);
    r = int(random(100));
    g = int(random(100));
    b = int(random(100));
    health = 110 * size;
    seen = 0;
    looking = 0;
    int chooser = int(random(100));
    int picker = int(random(100));
    if (chooser % 2 == 0) {
      x = random(30, width-30);
      if (picker % 2 == 0) {
        y = 30;
      } else {
        y = height - 30 - 75;
      }
    } else {
      y = random(30, height - 30 - 75);
      if (picker % 2 == 0) {
        x = 30;
      } else {
        x = width - 30;
      }
    }

    int choose = int(random(10));
    int pick = int(random(10));
    calc.x = choose;
    calc.y = pick;
    calc.normalize();
    xspeed = calc.x;
    yspeed = calc.y;
    movement = new PVector(0, 0);
    bleeding = 0;
  }

  void move() {


    xsee = xspeed;
    ysee = yspeed;

    if (seen == -180) {
      seen = 0;  
      int choose = int(random(10));
      int pick = int(random(10));
      calc.x = choose;
      calc.y = pick;
      calc.normalize();
      xspeed = calc.x;
      yspeed = calc.y;
    }


    seen -= 1;
    if (frameCount % 10 == 0) {

      if (bleeding > 0) {
        bleeding -= 4;
        if (bleeding % 20 == 0) {
          health -= 1;
          if (health < 1) {
            dead = 1020;
          }
        }
      }



      if (dist(x, y, p.location.x, p.location.y) < 800) {
        seen = 30;
        xlook= (p.location.x - x) / 100;
        ylook= (p.location.y - y) / 100;
        spotx = x;
        spoty = y;
        for (int u = 0; u < 100; u++) {
          spotx = x + (xlook * u);
          spoty = y + (ylook * u);
          for (int i = 0; i < walls.length; i++) {
            if (spotx > walls[i].x - walls[i].wide/2 && spotx < walls[i].x + walls[i].wide/2 && spoty > walls[i].y - walls[i].high/2 && spoty < walls[i].y + walls[i].high/2) {
              seen = 0;
            }
          }
        }
      }
      if (seen > 0) {
        movement.x = xlook;
        movement.y = ylook;
        movement.normalize();
        movement.mult(2.5);
        xspeed = movement.x;
        yspeed = movement.y;
        seen -=1;
      }
    }
    for (int i = 0; i < walls.length; i++) {
      if (frameCount % 100 == 0 && x > walls[i].x - walls[i].wide/2 && x < walls[i].x + walls[i].wide/2 && y > walls[i].y - walls[i].high/2 && y < walls[i].y + walls[i].high/2) {
        spawn();
      }
      if (x > walls[i].x - walls[i].wide/2 && x < walls[i].x + walls[i].wide/2 && y+yspeed > walls[i].y - walls[i].high/2 && y+yspeed < walls[i].y + walls[i].high/2) {
        yspeed = yspeed * -1;
      }

      if (x+xspeed > walls[i].x - walls[i].wide/2 && x+xspeed < walls[i].x + walls[i].wide/2 && y > walls[i].y - walls[i].high/2 && y < walls[i].y + walls[i].high/2) {
        xspeed = xspeed * -1;
      }
    }
  }


  void walk() {
    if (dist(p.location.x, p.location.y, x, y) > 40) {
      x+=xspeed * speed;
      y+=yspeed * speed;
    }
  }

  void display() {
    if (attack > 0) {
      attack -= 1;
    }
    pushMatrix();
    translate(x, y);
    scale(size, size);
    if (dist(p.location.x, p.location.y, x, y) < 45 && seen > 0) {
      rotate(atan2((y + ysee)-y, (x + xsee)-x ));
    } else {
      rotate(atan2((y + yspeed)-y, (x + xspeed)-x ));
    }
    strokeWeight(2);
    stroke(0);
    fill(r, g, b);
    rect(10 + attack / 3, 20, 30, 10, 2);
    rect(10 + attack / 3, -20, 30, 10, 2);
    rect(0, 0, 20, 50, 5);
    fill(0, 100, 0);
    ellipse(0, 0, 30, 30);
    ellipse(30+ attack / 3, -20, 15, 15);
    ellipse(30+ attack / 3, 20, 15, 15);
    popMatrix();
    fill(255, 0, 0, 100);
    noStroke();
    rect(x, y - 50, health/2, 12);
    fill(0);
    textAlign(CENTER);
    textSize(2);
    textFont(zFont);
    pushMatrix();
    translate(x, y-47);
    scale(1.5, 1);
    text(int(health), 0, 0);
    popMatrix();
    fill(0, 0);
    stroke(0);
    strokeWeight(1);
    rect(x, y - 50, 55 * size, 12);
    if (bleeding > 0) {
      noStroke();
      fill(255, 0, 0, bleeding * 3);
      ellipse(x+30, y, 20, 20);
      triangle(x + 20, y, x + 40, y, x + 30, y - 20);
    }
  }
  //dank
  void attack() {
    for (int q = 0; q < p.maxBullets; q++) {
      if (w.weapon != 3) {
        if (dist(bullets[q].x, bullets[q].y, x, y) < 20) {   
          bleeding = 100;
          bullets[q].x = -100 - xBoundary;
          if (w.weapon == 1) {
            health -= 55;
          } else if (w.weapon == 2) {
            health -= 45;
          }
          if (health < 1) {
            dead = 1020;
          }
        }
      } else {
        if (dist(bullets[0].x, bullets[0].y, x, y) < 40) {  
          if (w.canknife = true) {
            bleeding = 128;
            health -= 100;
            bullets[0].x = -100;
            w.canknife = false;
            if (health < 1) {
              dead = 1020;
            }
          }
        }
      }
    }//so dank
    if (dist(p.location.x, p.location.y, x, y) < 40 && seen > 0) {
      if (attack == 0) {
        p.health -= 15;
        attack = 20;
      }
    }
  }

  void died() {
    if (dead == 1) {
      x = -100-xBoundary;
    }
    pushMatrix();
    translate(x, y);
    rotate(atan2((y + ysee)-y, (x + xsee)-x ));
    scale(size, size);
    scale(0.9, 0.9);
    strokeWeight(1);
    stroke(100, 0, 0, dead);
    fill(150, 10, 10, dead - 20);
    ellipse(-55 + bloodx, 0 + bloody, 10, 10);
    ellipse(-65 - bloodx, 0 + bloody, 10, 10);
    ellipse(-75 - bloodx, 5 - bloody, 10, 10);
    ellipse(-50 + bloody, -10 + bloodx, 10, 10);
    ellipse(-65 - bloody, 2 + bloodx, 10, 10);
    ellipse(-50 - bloody, -5 - bloodx, 10, 10);
    ellipse(-75 - bloodx, 2 + bloodx, 10, 10);
    ellipse(-70 - bloodx, -5 - bloodx, 10, 10);
    ellipse(-60 + bloodx, 5 + bloodx, 10, 10);
    ellipse(-55 - bloody, 2 + bloody, 10, 10);
    ellipse(-70 - bloody, -5 - bloody, 10, 10);
    ellipse(-80 + bloody, 5 + bloody, 10, 10);
    fill(0, 100, 0, dead/3);
    stroke(0, dead/3);
    strokeWeight(1);
    rect(67, 14, 10, 17, 3);
    rect(71, -11, 17, 10, 3);
    ellipse(6, 48, 13, 13);
    ellipse(14, -30, 13, 13);
    ellipse(-40, 0, 30, 30);
    fill(r, g, b, dead/3);
    pushMatrix();
    rotate(1);
    rect(23, 21, 38, 11);
    popMatrix();
    pushMatrix();
    rotate(-13);
    rect(7, -22, 38, 11);
    popMatrix();
    rect(44, 10, 40, 12, 2);
    rect(44, -10, 40, 12, 2);
    rect(0, 0, 50, 35, 5);
    popMatrix();
  }

  void execute() {
    if (x > 1 - xBoundary) {
      if (dead < 1) {
        move();
        display();
        attack();
        walk();
      }  
      if (dead > 1) {
        dead -= 1;
      }
    }
  }
}