
class Bullet {
  PVector velocity;
  float x;
  float y;
  int spawn;

  Bullet() {

    velocity = new PVector(0, 0);

    int can = 0;
  }

  void call() {
    if (spawn == 0) {
      if (controller == false) {
        velocity.x = mouseX - width/2;
        velocity.y = mouseY - height/2;
      } else {
        if(X2 != 0) {
         velocity.x = X2;
        } else {
         velocity.x = X1; 
        }
        if(Y2 != 0) {
          velocity.y = Y2;
        } else {
          velocity.y = Y1;
        }
      }
      velocity.normalize();
      velocity.mult(20);

      if (w.weapon == 2) {
        velocity.x = velocity.x + random(-0.8 * w.recoil/15, 0.8 * w.recoil/15);
        velocity.y = velocity.y+ random(-0.8 * w.recoil/15, 0.8 * w.recoil/15);
      }
      if (w.weapon == 1) { 
        velocity.x = velocity.x + random(-1 * w.recoil/45, 1 * w.recoil/45);
        velocity.y = velocity.y+ random(-1 * w.recoil/45, 1 * w.recoil/45);
      }

      x = p.location.x;
      y = p.location.y;
      spawn = 1;
    }
  }

  void move() { 
    x += velocity.x;
    y += velocity.y;
  }

  void collide() {
    for (int i = 0; i < walls.length; i++) {
      if (x > walls[i].x - walls[i].wide/2 && x < walls[i].x + walls[i].wide/2 && y > walls[i].y - walls[i].high/2 && y < walls[i].y + walls[i].high/2) {
        x = -100;
        y = -100;
      }
    }
  }

  void display() {
    if (dist(x, y, p.location.x, p.location.y) > 300);
    strokeWeight(1);
    fill(255, 100, 0);
    stroke(255);
    ellipse(x, y, 2, 2);
  }
}