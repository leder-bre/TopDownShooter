class Weapons {
  int totpammo = 30;
  int totmammo = 60;
  int weapon = 1;
  int canShoot = 0;
  int fireRate = 0;
  int recoil = 0;
  int pammo = 10;
  int mammo = 30;
  int knife = 200;
  boolean canknife = true;
  boolean shot = false;
  int lookDist = 3;
  /*
  Weapon
   1  = Pistol
   2 = AR
   3 = Melee
   */

  void wsetup() {
    totpammo = 30;
    totmammo = 60;
    weapon = 1;
    canShoot = 0;
    fireRate = 0;
    recoil = 0;
    pammo = 16;
    mammo = 30;
    knife = 200;
    canknife = true;
    shot = false;
  }

  void run() {

    if (recoil > 0) {
      recoil -= recoil/40;
      recoil -= 2;
    }
    if (weapon == 1) {
      canShoot = 0;
      fireRate = 0;
    }

    if (weapon == 2) {
      fireRate = 5;
      shot = false;
      if (canShoot > 0) {
        canShoot -= 1;
      }
    }

    if (weapon == 3) {
      fireRate = 10;
      if (canShoot > 0) {
        canShoot -= 1;
      }
    }
    pushMatrix();
    translate(0, 9);
    if (weapon == 1) {
      stroke(0, 40);
      fill(140, 140, 140, 150);
      rect(width-171, height-25, 315, 29, 3);
      for (int p = 0; p < 15; p++) {
        fill(140, 140, 40, 150);
        stroke(70, 70, 20, 200);
        rect(width - 25 - p * 21, height-26, 16, 28, 2);
      }
      for (int o = 0; o < pammo; o++) {
        fill(200, 200, 90, 200);
        stroke(255);
        rect(width - 25 - o * 21, height-26, 16, 28, 2);
      }
      stroke(0);
      fill(125);
      rect(90, height-81, 12, 12);
      fill(0);
      textSize(14);
      text("1", 90, height-76);
    }
    if (weapon == 2) {
      stroke(0, 40);
      fill(140, 140, 140, 150);
      rect(width-166, height-25, 300, 30, 3);
      for (int p = 0; p < 30; p++) {
        fill(140, 140, 40, 150);
        stroke(70, 70, 20, 200);
        rect(width - 20 - p * 11, height-26, 7, 28, 1);
      }
      for (int o = 0; o < mammo; o++) {
        fill(200, 200, 90, 200);
        stroke(255);
        rect(width - 20 - o * 11, height-26, 7, 28, 1);
      }
      stroke(0);
      fill(125);
      rect(90, height-81, 12, 12);
      fill(0);
      textSize(14);
      text("2", 90, height-76);
    }
    if (weapon == 3) {
      if (knife < 200) {
        knife += 8;
      } else {
        canknife = true;
      }
      fill(140, 140, 40, 150);
      if (knife < 200) {
        stroke(70, 70, 20, 200);
      } else {
        stroke(255);
      }
      rect(width - 172, height-27, 200 * 1.5, 28, 3);
      fill(200, 200, 90, 200);
      rect(width - 22 - 1.5 * knife/2, height-27, knife * 1.5, 28, 3);
      //Number
      stroke(0);
      fill(125);
      rect(90, height-81, 12, 12);
      fill(0);
      textSize(14);
      text("3", 90, height-76);
    }

    textFont(p.fontext, 20);
    fill(0);
    if (weapon == 1) {
      text("Ammo: " + pammo + "/" + totpammo, width-250, height-20);
    }
    if (weapon == 2) {
      text("Ammo: " + mammo + "/" + totmammo, width-223, height-20);
    }
    popMatrix();

    pushMatrix();
    translate(0, height - 71);
    fill(180, 200);
    noStroke();
    rect(206, 41, 400, 69, 2);

    pushMatrix();
    translate(141, -224);
    rotate(0.8);
    if (weapon == 3) {
      fill(30, 50, 70);
      stroke(0);
    } else {
      stroke(0, 100);
      fill(30, 50, 70, 100);
    }
    beginShape();
    vertex(313, 60);
    vertex(317, 49);
    vertex(321, 42);
    vertex(323, 38);
    vertex(330, 40);
    vertex(328, 46);
    vertex(324, 53);
    vertex(318, 64);
    endShape(CLOSE);

    if (weapon == 3) {
      fill(90);
      stroke(0);
    } else {
      fill(90, 100);
      stroke(0, 100);
    }
    beginShape();
    vertex(330, 41);
    vertex(339, 47);
    vertex(331, 39);
    vertex(353, 1);
    vertex(355, -11);
    vertex(349, -4);
    vertex(345, -1);
    vertex(325, 38);
    vertex(313, 35);
    vertex(321, 38);
    endShape(CLOSE);

    if (weapon == 3) {
      fill(127);
    } else {
      fill(127, 100);
    }
    noStroke();
    beginShape();
    vertex(356, -10);
    vertex(355, -2);
    vertex(332, 39);
    vertex(332, 35);
    endShape(CLOSE);

    popMatrix();
    if (w.weapon == 1) {
      fill(150);
      stroke(10);
    } else {
      fill(150, 100);
      stroke(10, 100);
    }
    beginShape();
    vertex(16, 50);
    vertex(24, 28);
    vertex(21, 23);
    vertex(25, 14);
    vertex(84, 14);
    vertex(84, 20);
    vertex(81, 23);
    vertex(80, 25);
    vertex(45, 25);
    vertex(34, 52);
    endShape(CLOSE);
    line(23, 21, 83, 21);
    line(29, 14, 29, 21);
    line(31, 14, 31, 21);
    line(33, 14, 33, 21);
    line(35, 14, 35, 21);
    line(37, 14, 37, 21);
    line(39, 14, 39, 21);
    if (w.weapon == 1) {
      fill(115, 75, 25);
    } else {
      fill(115, 75, 25, 100);
    }
    beginShape();
    vertex(28, 25);
    vertex(41, 27);
    vertex(32, 50);
    vertex(20, 48);
    endShape(CLOSE);

    if (w.weapon == 1) {
      fill(70);
    } else {
      fill(70, 100);
    }
    ellipse(33, 32, 3, 3);
    ellipse(28, 46, 3, 3);

    int lokx = 100;
    if (w.weapon == 2) {
      fill(165, 75, 15);
      strokeWeight(1);
      stroke(0);
    } else {
      fill(165, 75, 15, 100);
      strokeWeight(1);
      stroke(0, 100);
    }
    rect(123+lokx, 24, 22, 11);
    rect(114+lokx, 19, 40, 8);
    rect(70+lokx, 34, 9, 17);
    triangle(20+lokx, 23, 80+lokx, 17, 27+lokx, 44);
    if (w.weapon == 2) {
      fill(30);
    } else {
      fill(30, 100);
    }
    beginShape();
    vertex(120+lokx, 45);
    vertex(108+lokx, 48);
    vertex(94+lokx, 30); //**
    vertex(87+lokx, 23);
    vertex(100+lokx, 25);
    vertex(107+lokx, 38);
    endShape(CLOSE);
    rect(86+lokx, 22, 55, 10);
    rect(92+lokx, 17, 55, 8);
    rect(155+lokx, 26, 40, 3);
    triangle(152+lokx, 19, 158+lokx, 26, 164+lokx, 25);
    rect(145+lokx, 19, 20, 2);
    fill(0, 0);
    if (weapon == 2) {
      stroke(0);
    } else {
      stroke(0, 100);
    }
    strokeWeight(2);
    rect(80+lokx, 30, 10, 6);
    popMatrix();
    fill(200, 200, 20);
    strokeWeight(1);
    stroke(0);
    rect(width - 380, height - 15, 6, 16);
    rect(width - 360, height - 15, 6, 16);
    rect(width - 370, height - 15, 6, 16);
    triangle(width-380, height-30, width-383, height-25, width-377, height-25);
    triangle(width-370, height-30, width-373, height-25, width-367, height-25);
    triangle(width-360, height-30, width-363, height-25, width-357, height-25);
    
    stroke(0);
      fill(125);
      rect(90, height-72, 12, 12);
      rect(241, height-72, 12, 12);
      rect(392, height-72, 12, 12);
      fill(0);
      textSize(14);
      text("1", 90, height-67);
      text("2", 241, height-67);
      text("3", 392, height-67);
  }
}