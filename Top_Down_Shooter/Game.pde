class Game {

  int wavelength = 2;
  int surviving;
  float countdown = 3600;
  PVector move;
  float wi;
  float hi;

  void gsetup() {
    ran = true;
    for (int q = 0; q < bullets.length; q++) {
      bullets[q] = new Bullet();
    }
    move = new PVector(0, 0);
    walls[0]= new Wall(width/2, 5-yBoundary, width+2*xBoundary, 10);
    walls[1]= new Wall(5-xBoundary, height/2, 10, height+2*yBoundary);
    walls[2]= new Wall(width/2, height-45+yBoundary, width+2*yBoundary, 10);
    walls[3]= new Wall(width-5+xBoundary, height/2, 10, height+yBoundary*2);
    for (int y = 4; y < walls.length; y++) {
      walls[y] = new Wall(random(0-xBoundary, width+xBoundary), random(0-yBoundary, height+yBoundary), random(width/40, width/10), random(height/40, height/10));
    }
    rectMode(CENTER);

    w.mammo = 30;
    w.pammo = 15;
    for (int q = 0; q < z.length; q++) {
      z[q] = new Zombie();
    }
    for (int q = 0; q < wavelength; q++) {
      z[q].spawn();
    }
    hi = float(height);
    wi = float(width);
    w.wsetup();
    //p = new Player(wi/2, hi/2);
    pick.Pickup();
  }

  void gdraw() {
    if (controller = true) {
      p.velocity.x = 2*(X1/100);
      p.velocity.y = 2*(Y1/100);
      if (R31 == 0) {
        p.sprinting = true;
      } else {
        p.sprinting = false;
        gmouseReleased();
      }
    }
    //pushMatrix();

    //translate(width/2 - p.location.x, height/2 - p.location.y);


    looking.x=mouseX - wi/2;
    looking.y=mouseY - hi/2;
    looking.normalize();

    //popMatrix();



    if (w.weapon == 3 && w.knife<50 && w.canknife == true) {
      for (int i = 10; i < 60; i++) {
        bullets[0].x = p.location.x + looking.x * i;
        bullets[0].y = p.location.y + looking.y * i;
      }
    } else {
      bullets[0].x = -99;
    }

    distance = 2*sqrt(((mouseX - wi/2)*(mouseX - wi/2))+((mouseY - hi/2)*(mouseY - hi/2)))/(wi/4);
    if (w.weapon == 1) {
      accuracy = 0.5;
    } else if (w.weapon == 2) {
      accuracy = 1.5;
    } else {
      accuracy = 0.2;
    }
    if (pause == false) {

      if (w.recoil > 10) {
        distance *= w.recoil/10;
        distance *= accuracy;
      } else {
        distance += w.recoil/20;
        distance *= accuracy;
      }
      fill(100, 20);
      background(100);
      stroke(255);
      strokeWeight(2);
      line(mouseX + 10 * distance, mouseY, mouseX + 15* distance, mouseY);
      line(mouseX - 10* distance, mouseY, mouseX - 15* distance, mouseY);
      line(mouseX, mouseY + 10* distance, mouseX, mouseY + 15* distance);
      line(mouseX, mouseY - 10* distance, mouseX, mouseY - 15* distance);


      pushMatrix();


      translate(width/2 - p.location.x, height/2 - p.location.y);


      for (int q = 1; q < p.maxBullets; q++) {
        bullets[q].call();
        if (bullets[q].x > -100 && bullets[q].x < width+100 && bullets[q].y > -100 && bullets[q].y < height +100) {
          bullets[q].move();
          bullets[q].display();
          bullets[q].collide();
        }
      }

      for (int i = 0; i < wavelength; i++) {
        if (z[i].dead > 1 && z[i].x > 0) {
          z[i].died();
          z[i].dead -= 1;
        }
      }

      for (int q = 0; q < wavelength; q++) {
        if (z[q].dead < 1) {
          surviving += 1;
          z[q].execute();
        }
      }

      for (int u = 0; u < walls.length; u++) {
        walls[u].display();
      }

      pick.display();

      pick.run();

      p.move();

      p.display();
      for (int u = 0; u < walls.length; u++) {
        walls[u].displayTop();
      }

      p.shoot();

      p.HUD2();

      popMatrix();

      pushMatrix();
      stroke(255);
      line(mouseX + 10 * distance, mouseY, mouseX + 15* distance, mouseY);
      line(mouseX - 10* distance, mouseY, mouseX - 15* distance, mouseY);
      line(mouseX, mouseY + 10* distance, mouseX, mouseY + 15* distance);
      line(mouseX, mouseY - 10* distance, mouseX, mouseY - 15* distance);
      popMatrix();

      fill(200);
      rect(width/2, height - 40, width, 80);
      p.HUD();
      w.run();

      fill(200);
      textSize(25);
      textAlign(RIGHT);
      text("Wave: " + wavelength/2, width-10, 30);
      textAlign(LEFT);

      if (surviving == 0) {
        if (countdown > 200 + wavelength * 30) {
          countdown = 200 + wavelength * 30;
        }
      }
      text("Next Wave: " + countdown/60, width-175, 60);
      countdown -= 1;
      if (countdown == 0) {
        wavelength += 2;
        for (int q = 0; q < wavelength + surviving; q++) {
          z[q].spawn();
        }
        countdown = 3600 + wavelength * 30;
      }


      surviving = 0;
    }
  }

  void gmouseReleased() {
    w.shot = false;
  }

  void gkeyPressed() {
    if (key == 'p' || key== 'P') {

      if (pause == true) {
        pause = false;
      } else {
        pause = true;
      }
    }
    if (controller == false) {
      if (keyCode == SHIFT) {
        p.sprinting = true;
      }

      if (key == 'a' || key == 'A') {
        p.velocity.x = -2;
        p.runninga = true;
      }

      if (key == 'd'|| key == 'D') {
        p.velocity.x = 2;
        p.runningd = true;
      }

      if (key == 'w' ||key == 'W') {
        p.velocity.y = -2;
        p.runningc = true;
      }

      if (key == 's'||key == 'S') {
        p.velocity.y = 2;
        p.runningb = true;
      }
    } else {
    }
    if (key == '1' || key == '!') {
      w.weapon = 1;
    }

    if (key == '2' || key == '@') {
      w.weapon = 2;
    }
    if (key == '3' || key == '#') {
      w.weapon = 3;
    }
  }

  void gkeyReleased() {

    if (keyCode == SHIFT) {
      p.sprinting = false;
    }

    if (key == 's' || key == 'S' || key == 'w' || key == 'W') {
      p.velocity.y = 0;
    }

    if (key == 's' || key == 'S' ) {
      p.runningb = false;
    }
    if (key == 'w' || key == 'W' ) {
      p.runningc = false;
    }

    if (key == 'd' || key == 'D'||key == 'a' || key == 'A') {
      p.velocity.x = 0;
    }

    if (key == 'd' || key == 'D') {
      p.runningd = false;
    }

    if (key == 'a' || key == 'A') {
      p.runninga = false;
    }

    if (key == 'z'|| key == 'Z') {
      for (int q = 0; q < wavelength; q++) {
        z[q].spawn();
      }
    }
  }
}