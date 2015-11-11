class Wall {
  float x;
  float y;
  float wide;
  float high;
  PVector move;

  Wall(float tempX, float tempY, float tempWide, float tempHigh) {
    x = tempX; 
    y = tempY;
    wide = tempWide;
    high = tempHigh;
    move = new PVector(0, 0);
  }

  void display() {
    if (frameCount % 2 == 0) {
      if (p.health > 0) {
        move.x = x - p.location.x;
        move.y = y - p.location.y;
        move.mult(0.2);
      }
    }
    fill(50, 40, 30); 
    if (move.x > 0) {
      if (move.y > 0) {
        beginShape();
        vertex(x+wide/2, y-high/2); //+-
        vertex(x-wide/2, y-high/2); //--
        vertex(x-wide/2, y+high/2); //-+
        vertex(x+move.x-3*wide/8, y+move.y+3*high/8); //-+
        vertex(x+move.x+3*wide/8, y+move.y+3*high/8); //++
        vertex(x+move.x+3*wide/8, y+move.y-3*high/8); //+-
        endShape();
      } else {
        beginShape();
        vertex(x+wide/2, y+high/2); //+-
        vertex(x-wide/2, y+high/2); //--
        vertex(x-wide/2, y-high/2); //-+
        vertex(x+move.x-3*wide/8, y+move.y-3*high/8); //-+
        vertex(x+move.x+3*wide/8, y+move.y-3*high/8); //++
        vertex(x+move.x+3*wide/8, y+move.y+3*high/8); //+-
        endShape();
      }
    } else {


      if (move.y > 0) {
        beginShape();
        vertex(x-wide/2, y-high/2); //+-
        vertex(x+wide/2, y-high/2); //--
        vertex(x+wide/2, y+high/2); //-+
        vertex(x+move.x+3*wide/8, y+move.y+3*high/8); //-+
        vertex(x+move.x-3*wide/8, y+move.y+3*high/8); //++
        vertex(x+move.x-3*wide/8, y+move.y-3*high/8); //+-
        endShape();
      } else {
        beginShape();
        vertex(x-wide/2, y+high/2); //+-
        vertex(x+wide/2, y+high/2); //--
        vertex(x+wide/2, y-high/2); //-+
        vertex(x+move.x+3*wide/8, y+move.y-3*high/8); //-+
        vertex(x+move.x-3*wide/8, y+move.y-3*high/8); //++
        vertex(x+move.x-3*wide/8, y+move.y+3*high/8); //+-
        endShape();
      }
    }
    fill(50, 40, 30); 
    noStroke();
    rect(x, y, wide, high);
    stroke(0);
    strokeWeight(1);
    line(x+3*wide/8+move.x, y+3*high/8+move.y, x+wide/2, y+high/2);
    line(x+3*wide/8+move.x, y-3*high/8+move.y, x+wide/2, y-high/2);
    line(x-3*wide/8+move.x, y-3*high/8+move.y, x-wide/2, y-high/2);
    line(x-3*wide/8+move.x, y+3*high/8+move.y, x-wide/2, y+high/2);
  }

  void displayTop() {
    fill(50, 40, 30); 
    stroke(0);
    strokeWeight(2);
    rect(x+move.x, y+move.y, 3*wide/4, 3*high/4);
    strokeWeight(1);
  }
}
