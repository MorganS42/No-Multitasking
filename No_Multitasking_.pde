// No Multitasking!

//import ddf.minim.*;

//Minim minim;

//AudioPlayer player;

// Main character initial vars
float x; 
float y;
int size;
int speedRight = 0;
int speedLeft = 0;
int speedXMax = 10; 
int speedYMin = -10; //Charatcer can control going up, so there's a min. But the chracter can't control going down, so there's no need for a max.
int speedY = 0; //Gravitional force
float flightPower = 100; //Jet pack fuel
boolean noSpikes=false;
float spikeTime;
boolean ts = false;

// 2nd character initial vars 
float x2;
float y2;
int size2;
int speedRight2 = 0;
int speedLeft2 = 0;
int speedXMax2 = 10;
int speedYMin2 = -10;
int speedY2 = 0;
float flightPower2 = 100;

//Feild Movement
float ss = 1; //ss = screenSpeed
float pcFake = 0; //pc = pixelCount, used to check when to change level
float pcReal = 0; //pc = pixelCount, used to tell how many pixels the chracter travled

//Game vars
int level = 1; 
int coin = 0;
boolean dead = false;
boolean restart = false;
boolean clickHelp = false; //limits mousePressed events to one time
int skinR=230; //red skin
int skinG=100; //green skin
int skinB=255; //blue skin

//Vars for shop
//sfill is to highlight the menu button as well as the chracters when hovered over.
//a,b,c = r,g,b
int sfill = 0; //sfill = storeFill, for menu button, base color

int sfill2a = skinR; //sfill2 is for speedboost
int sfill2b = skinG;
int sfill2c = skinB;

int sfill3a = skinR; //sfill3 is for more coin upgrade
int sfill3b = skinG;
int sfill3c = skinB;
int coinUpgrade = 0; //counting amount of coin upgrades

int sfill4a = skinR; //sfill4 is for more flightpower
int sfill4b = skinG;
int sfill4c = skinB;
int flightPowerUpgrade=0; //counting amount of flightpower upgrades

int sfill5a = skinR; //sfill5 is for a fireball sheild
int sfill5b = skinG;
int sfill5c = skinB;
boolean fireballSheild = false;

int sfill7a = skinR;
int sfill7b = skinG;
int sfill7c = skinB;
int sp = 200; //sp = sprite price
int spikePower=0;
int oldSpikePower=0;

int sfill6 = 0; //sfill6 is for the skins button

boolean skins=false; //skin button

int skinRFake=skinR; //red skin, it's fake because it won't be saved unless payed for.
int skinGFake=skinG; //green skin, it's fake because it won't be saved unless payed for.
int skinBFake=skinB; //blue skin, it's fake because it won't be saved unless payed for.

int sfill7 = 0; //for the back button in the skins screen
int sfill8 = 0; //for the buy button for the skin


//tutorial vars
int tf = 0; //tf = tutorial fill menu button color
int stage = 0; //The stage of the tutorial

boolean menuScreen = true;
boolean th = false; //th = tutorial help
String clicked; //Passes the name of the button clicked to menuClicked function

//Arrays for objects
spike[] spikeArray = new spike[30]; 
fireball[] fireballArray = new fireball[100]; 
button[] buttonArray = new button[5];
coin[] coinArray = new coin[30];
poisonSpike[] poisonSpikeArray = new poisonSpike[10];
cloud[] cloudArray = new cloud[10];
goldenCloud[] goldenCloudArray = new goldenCloud[2];

//Boss Battle vars

boolean rs=false; //rs = remove spikes
bossBattle[] boss = new bossBattle[1]; 

void setup() {
  fullScreen();
  background(255);
  x = width/2;
  y = height/2;
  size = 42;
  x2 = width/2;
  y2 = height/2;
  size2 = 42;

  for (int i = 0; i < 30; i++) {
    spikeArray[i] = new spike(0-20*3, height/2+height/3, 20);
  }
  for (int i = 0; i < 100; i++) {
    fireballArray[i] = new fireball(round(random(1, width)), height-50, 20);
  }
  for (int i = 0; i < 30; i++) {
    coinArray[i] = new coin(0, round(random(height/2+height/3-50, 50)), 20);
  }
  for (int i = 0; i < 10; i++) {
    poisonSpikeArray[i] = new poisonSpike(0-20*3, height/2+height/3, 20);
  }
  for (int i = 0; i < 10; i++) {
    cloudArray[i] = new cloud(round(random(0, width)), round(random(0, height/2)), 20);
  }
  buttonArray[1] = new button(width/2-210, height/2-100, 340, 75, width/2-105, "play");
  buttonArray[2] = new button(width/2-210, height/2+100, 340, 75, width/2-115, "store");
  buttonArray[3] = new button(width/2-210, height/2, 340, 75, width/2-180, "multiplayer");
  buttonArray[4] = new button(width/2-210, height/2+200, 340, 75, width/2-140, "tutorial");

  boss[0] = new bossBattle(width/2, 0, size*5);
  //,goldenCloudArray[1] = new goldenCloud(width/2,round(random(height/4,height/2)),50);

  //minim = new Minim(this);

  //player = minim.loadFile("Hall of the Mountain King.mp3"); //the song
}

void draw() {

  background(255, 0, 255);

  if (dead==true) {
    fill(0);
    textSize(32);
    text("YOU LOSE", width/2-width/12, height/1.15);
    String a = ""+round(pcReal-width/2+x);
    int z = a.length();
    text("You travelled "+a+" pixels.", width/2-width/8-(z*16), height/1.05);
  }


  textSize(32);
  fill(0);
  text("No Multitasking!", width/2-width/8.7, height/2-height/2.5);


  buttonArray[1].display();
  buttonArray[1].clicked();
  buttonArray[2].display();
  buttonArray[2].clicked();
  buttonArray[3].display();
  buttonArray[3].clicked();
  buttonArray[4].display();
  buttonArray[4].clicked();


  if (clicked=="store") {

    if (skins) {
      background(255, 255, 200);
      fill(255, 0, 0);
      textSize(64);
      text("RED", width/2-100, height/2+100);
      fill(0, 255, 0);
      text("GREEN", width/2-135, height/2+250);
      fill(0, 0, 255);
      text("BLUE", width/2-110, height/2+400);
      textSize(32);
      fill(0);
      text(round(skinRFake/2.55)+"%", width/2-75, height/2+50);
      text(round(skinGFake/2.55)+"%", width/2-75, height/2+200);
      text(round(skinBFake/2.55)+"%", width/2-75, height/2+350);
      textSize(32);
      fill(0);
      text("No Multitasking!", width/2-width/8.7, height/2-height/2.5);
      textSize(24);
      text("Coins:"+coin, width-120, height/2-height/2.5);

      fill(skinRFake, skinGFake, skinBFake);
      rect(width/2-size*3, height/2-height/3, size*4, size*4, 10);

      fill(0);
      ellipse(width/2-size/8, height/2-size*6, size*1.5, size*1.5);
      ellipse(width/2-size*2, height/2-size*6, size*1.5, size*1.5);

      fill(255, 0, 0);
      triangle(width/2-size*2, height/2-size*5, width/2-size*1.0625, height/2-(size*4)/1.1, width/2-size/8, height/2-size*5); 

      fill(0);
      rect(width/2+70, height/2+50, 10, 50);
      rect(width/2+50, height/2+70, 50, 10);

      rect(width/2-170, height/2+70, 50, 10);


      rect(width/2+100, height/2+200, 10, 50);
      rect(width/2+80, height/2+220, 50, 10);

      rect(width/2-200, height/2+220, 50, 10);


      rect(width/2+80, height/2+350, 10, 50);
      rect(width/2+60, height/2+370, 50, 10);

      rect(width/2-180, height/2+370, 50, 10);

      if (mousePressed && mouseX>width/2+50 && mouseX<width/2+120 && mouseY>height/2+50 && mouseY<height/2+120 && skinRFake<256) {
        skinRFake=skinRFake+1;
      }
      if (mousePressed && mouseX>width/2-170 && mouseX<width/2-120 && mouseY>height/2+70 && mouseY<height/2+80 && skinRFake>-1) {
        skinRFake=skinRFake-1;
      }

      if (mousePressed && mouseX>width/2+80 && mouseX<width/2+150 && mouseY>height/2+200 && mouseY<height/2+270 && skinGFake<256) {
        skinGFake=skinGFake+1;
      }
      if (mousePressed && mouseX>width/2-200 && mouseX<width/2-150 && mouseY>height/2+220 && mouseY<height/2+270 && skinGFake>-1) {
        skinGFake=skinGFake-1;
      }

      if (mousePressed && mouseX>width/2+60 && mouseX<width/2+130 && mouseY>height/2+350 && mouseY<height/2+420 && skinBFake<256) {
        skinBFake=skinBFake+1;
      }
      if (mousePressed && mouseX>width/2-180 && mouseX<width/2-130 && mouseY>height/2+370 && mouseY<height/2+380 && skinBFake>-1) {
        skinBFake=skinBFake-1;
      }

      fill(sfill7);
      rect(5, height-70, 110, 50, 20);

      fill(sfill8);
      rect(width/2-130, height/2-size/4-40, 175, 60, 20);

      fill(150);
      textSize(32);
      text("Buy, $50", width/2-110, height/2-size/4);
      text("Back", 20, height-30);

      if (mouseX>5 && mouseX<115 && mouseY>height-70 && mouseY<height-10) {
        sfill7=100;
        if (mousePressed==true) {
          skins=false;
        }
      } else {
        sfill7=0;
      }

      if (mouseX>width/2-130 && mouseX<width/2+45 && mouseY>height/2-size/4-40 && mouseY<height/2+10) {
        sfill8=100;
        if (mousePressed==true && coin>49 && clickHelp==false) {
          clickHelp=true;
          coin=coin-50;
          skinR=skinRFake;
          skinG=skinGFake;
          skinB=skinBFake;
        }
      }
      else {
        clickHelp=false;
        sfill8=0;
      }
    }
    else {

      menuScreen=false;
      int dx = width/2-70; //dx = drawing x
      int dy = height/2; //dy = drawing y 

      background(255, 255, 200);

      textSize(32);
      fill(0);
      text("No Multitasking!", width/2-width/8.7, height/2-height/2.5);
      textSize(24);
      text("Coins:"+coin, width-120, height/2-height/2.5);
      text("Speedboost $20", dx-70, dy+size+30);
      text("More Flight Power $25", dx-100, dy-size*4-20);
      text("More Coins $30", dx-70, dy+size+30+size*4);
      text("Fireball Shield $100", dx-90, dy+size+30+size*7);
      text("Spike Power $" + sp, dx+180, dy+size+30);

      fill(sfill);
      rect(10, 10, 80, 40, 20);            
      textSize(24);
      fill(150);
      text("Menu", 20, 40);

      fill(sfill6);
      rect(width-90, height-50, 80, 40, 20);
      fill(150);
      text("Skins", width-80, height-25);

      if (mouseX>10 && mouseX<80 && mouseY>10 && mouseY<40) {
        sfill=100;
        if (mousePressed==true) {
          background(255);
          clicked="";
          menuScreen=true;
        }
      } else {
        sfill=0;
      }


      if (mouseX<width-10 && mouseX>width-80 && mouseY<height-10 && mouseY>height-40) {
        sfill6=100;
        if (mousePressed==true) {
          skinRFake=skinR;
          skinGFake=skinG;
          skinBFake=skinB;
          skins=true;
        }
      } else {
        sfill6=0;
      }

      fill(sfill2a, sfill2b, sfill2c);
      rect(dx, dy, size, size, 10);
      
      fill(sfill7a, sfill7b, sfill7c);
      rect(dx+size*5.5+30, dy, size, size, 10);
      fill(0);
      ellipse(dx+size/4+size*5.5+30, dy+size/4, size/3.5, size/3.5);
      ellipse(dx+(size/4)*3+size*5.5+30, dy+size/4, size/3.5, size/3.5);
      fill(255, 0, 0);
      triangle(dx+size/4+size*5.5+30, dy+size/2, dx+size/2+size*5.5+30, dy+size/1.1, dx+(size/4)*3+size*5.5+30, dy+size/2);  
  
      fill(0);
      ellipse(dx+size/4, dy+size/4, size/3.5, size/3.5);
      ellipse(dx+(size/4)*3, dy+size/4, size/3.5, size/3.5);

      fill(255, 0, 0);
      triangle(dx+size/4, dy+size/2, dx+size/2, dy+size/1.1, dx+(size/4)*3, dy+size/2);  

      noFill();
      arc(dx-size/4, dy, size, size, PI/2, PI);
      arc(dx-size/4, dy+size/2, size, size, PI/2, PI);
      arc(dx-size/4, dy+size/4, size, size, PI/2, PI);


      if (coin>19) {
        if (mouseX>dx && mouseX<dx+size && mouseY>dy && mouseY<dy+size && clickHelp==false) {
          sfill2a=270;
          sfill2b=140;
          sfill2c=255;
          if (mousePressed==true) {
            coin=coin-20;
            speedXMax=speedXMax+5;
            sfill2a=270;
            sfill2b=140;
            sfill2c=255;
            if (mousePressed==true) {
              clickHelp=true;
              sfill2a=270;
              sfill2b=140;
              sfill2c=255;
            }
          }
        } else {
          sfill2a=230;
          sfill2b=100;
          sfill2c=255;
        }
      } else {
        sfill2a=128;
        sfill2b=128;
        sfill2c=128;
      }

      if (coin>29) {
        if (mouseX>dx && mouseX<dx+size && mouseY>dy+size*4 && mouseY<dy+size+size*4 && clickHelp==false) {
          sfill3a=270;
          sfill3b=140;
          sfill3c=255;
          if (mousePressed==true) {
            coin=coin-30;
            coinUpgrade=coinUpgrade+4;
            sfill3a=270;
            sfill3b=140;
            sfill3c=255;
            if (mousePressed==true) {
              clickHelp=true;
              sfill3a=270;
              sfill3b=140;
              sfill3c=255;
            }
          }
        } else {
          sfill3a=230;
          sfill3b=100;
          sfill3c=255;
        }
      }
      else {
        sfill3a=128;
        sfill3b=128;
        sfill3c=128;
      }
      
      if (coin>sp-1) {
        if (mouseX>dx+size*5.5+30 && mouseX<dx+size+size*5.5+30 && mouseY>dy && mouseY<dy+size && clickHelp==false) {
          sfill7a=270;
          sfill7b=140;
          sfill7c=255;
          if (mousePressed==true) {
            coin=coin-sp;
            sp=sp+sp;
            spikePower++;
            oldSpikePower++;
            sfill7a=270;
            sfill7b=140;
            sfill7c=255;
            if (mousePressed==true) {
              clickHelp=true;
              sfill7a=270;
              sfill7b=140;
              sfill7c=255;
            }
          }
        } else {
          sfill7a=230;
          sfill7b=100;
          sfill7c=255;
        }
      }
      else {
        sfill7a=128;
        sfill7b=128;
        sfill7c=128;
      }

      if (coin>24) {
        if (mouseX>dx && mouseX<dx+size && mouseY>dy-size*4 && mouseY<dy+size-size*4 && clickHelp==false) {
          sfill4a=270;
          sfill4b=140;
          sfill4c=255;
          if (mousePressed==true) {
            coin=coin-25;
            flightPowerUpgrade=flightPowerUpgrade+1;
            flightPower=flightPower+20;
            sfill4a=270;
            sfill4b=140;
            sfill4c=255;
            if (mousePressed==true) {
              clickHelp=true;
              sfill4a=270;
              sfill4b=140;
              sfill4c=255;
            }
          }
        } else {
          sfill4a=230;
          sfill4b=100;
          sfill4c=255;
        }
      } else {
        sfill4a=128;
        sfill4b=128;
        sfill4c=128;
      }

      if (coin>99) {
        if (mouseX>dx && mouseX<dx+size && mouseY>dy+size*7 && mouseY<dy+size+size*7 && clickHelp==false) {
          sfill5a=270;
          sfill5b=140;
          sfill5c=255;
          if (mousePressed==true && fireballSheild==false) {
            coin=coin-100;
            fireballSheild = true;
            sfill5a=270;
            sfill5b=140;
            sfill5c=255;
            if (mousePressed==true) {
              clickHelp=true;
              sfill5a=270;
              sfill5b=140;
              sfill5c=255;
            }
          }
        } else {
          sfill5a=230;
          sfill5b=100;
          sfill5c=255;
        }
      } else {
        sfill5a=128;
        sfill5b=128;
        sfill5c=128;
      }


      if (mousePressed==false) {
        clickHelp=false;
      }

      fill(sfill3a, sfill3b, sfill3c);
      rect(dx, dy+size*4, size, size, 10);

      fill(0);
      ellipse(dx+size/4, dy+size/4+size*4, size/3.5, size/3.5);
      ellipse(dx+(size/4)*3, dy+size/4+size*4, size/3.5, size/3.5);

      fill(255, 0, 0);
      triangle(dx+size/4, dy+size/2+size*4, dx+size/2, dy+size/1.1+size*4, dx+(size/4)*3, dy+size/2+size*4);

      fill(255, 255, 0);
      ellipse(dx+size, dy+size*4, 20, 20);
      ellipse(dx-size/4, dy+size*5, 20, 20);
      ellipse(dx-size/3, dy+size*4.5, 20, 20);
      ellipse(dx+size/1.3, dy+size*3.5, 20, 20);
      ellipse(dx+size, dy+size*4.8, 20, 20);
      ellipse(dx-size/3, dy+size*3.8, 20, 20);
      ellipse(dx+size/3.5, dy+size*3.5, 20, 20);



      fill(sfill4a, sfill4b, sfill4c);
      rect(dx, dy-size*4, size, size, 10);

      fill(0);
      ellipse(dx+size/4, dy+size/4-size*4, size/3.5, size/3.5);
      ellipse(dx+(size/4)*3, dy+size/4-size*4, size/3.5, size/3.5);

      fill(255, 0, 0);
      triangle(dx+size/4, dy+size/2-size*4, dx+size/2, dy+size/1.1-size*4, dx+(size/4)*3, dy+size/2-size*4);

      fill(255, 50, 0);
      ellipse(dx+size/2, dy-size*4+size*1.2, size/3, size/3);
      ellipse(dx+size/4, dy-size*4+size*1.2, size/3, size/3);
      ellipse(dx+size/1.25, dy-size*4+size*1.2, size/3, size/3);
      fill(255, 150, 0);
      ellipse(dx+size/2, dy-size*4+size*1.5, size/3, size/3);
      ellipse(dx+size/4, dy-size*4+size*1.5, size/3, size/3);
      ellipse(dx+size/1.25, dy-size*4+size*1.5, size/3, size/3);
      fill(255, 230, 0);
      ellipse(dx+size/2, dy-size*4+size*1.8, size/3, size/3);
      ellipse(dx+size/4, dy-size*4+size*1.8, size/3, size/3);
      ellipse(dx+size/1.25, dy-size*4+size*1.8, size/3, size/3);
      fill(255, 255, 0);
      ellipse(dx+size/2, dy-size*4+size*2.1, size/3, size/3);


      fill(sfill5a, sfill5b, sfill5c);
      rect(dx, dy+size*7, size, size, 10);

      fill(0);
      ellipse(dx+size/4, dy+size/4+size*7, size/3.5, size/3.5);
      ellipse(dx+(size/4)*3, dy+size/4+size*7, size/3.5, size/3.5);

      fill(255, 0, 0);
      triangle(dx+size/4, dy+size/2+size*7, dx+size/2, dy+size/1.1+size*7, dx+(size/4)*3, dy+size/2+size*7);

      noFill();
      arc(dx+size/2, dy+size*6.8, size, size, PI, PI*2);

      fill(255, 100, 25);
      ellipse(dx+size*1.2, dy+size/2+size*6, 20, 20);
    }
  }


  if (clicked=="play" || clicked=="multiplayer") {
    stage=0;
    //player.play();  
    menuScreen=false;
    background(80, 80, 255);
    switch(level) {
    case 1:
      ss=1;
      break;
    case 2:
      ss=1.2;
      break;
    case 3:
      ss=1.4;
      break;
    case 4:
      ss=1.5;
      break;
    case 5:
      ss=2;
      break;
    case 6:
      ss=2.4;
      break;
    case 7:
      ss=2.7;
      break;
    case 8:
      ss=3;
      break;
    case 9:
      ss=3.3;
      rs=true;
      break;
    case 10:
      ss=0;
      spikeTime=0;
      spikePower=0;
      boss[0].display();
      boss[0].move();
      boss[0].collision(x,y,speedLeft,speedRight, speedY, size);
      break;
    }
    if (level>10) {
      ss=level/8;
    }


    pcFake = pcFake + ss;
    pcReal = pcReal + ss;
    x=x+speedRight-speedLeft-ss;
    y=y+speedY;
    //background(80, 80, 255); is up above the level switch because of the boss.
    textSize(32);
    fill(0);
    text("No Multitasking!", width/2-width/8.7, height/2-height/2.5);
    textSize(24);
    text("Level:"+level, width-120, height/2-height/2.18);
    if (clicked=="play") {
      text("Flight Power:"+round(flightPower), width-200, height/2-height/2.33);
      text("Coins:"+coin, width-120, height/2-height/2.5);
    }
    
    if(ts) {
      fill(0);
      rect(x-size/3.8,y-size/4,size/3.8+size+size/3.8,size/4,15);
      rect(x+size/6,y-size*1.5,size-size/6-size/6,size*1.5,8);
    }
    fill(skinR, skinG, skinB);
    rect(x, y, size, size, 10);

    fill(0);
    ellipse(x+size/4, y+size/4, size/3.5, size/3.5);
    ellipse(x+(size/4)*3, y+size/4, size/3.5, size/3.5);

    fill(255, 0, 0);
    triangle(x+size/4, y+size/2, x+size/2, y+size/1.1, x+(size/4)*3, y+size/2);

    if (clicked=="multiplayer") {

      fill(0);
      textSize(24);
      text("Flight Power Player 1:"+round(flightPower), width-330, height/2-height/2.5);
      text("Flight Power Player 2:"+round(flightPower2), width-330, height/2-height/2.67);
      text("Coins:"+coin, width-120, height/2-height/2.33);

      x2=x2+speedRight2-speedLeft2-ss;
      y2=y2+speedY2;

      fill(255, 255, 0);
      rect(x2, y2, size2, size2, 10);

      fill(0);
      ellipse(x2+size2/4, y2+size2/4, size2/3.5, size2/3.5);
      ellipse(x2+(size2/4)*3, y2+size2/4, size2/3.5, size2/3.5);

      fill(255, 0, 0);
      triangle(x2+size2/4, y2+size2/2, x2+size2/2, y2+size2/1.1, x2+(size2/4)*3, y2+size2/2); 

      if (y2<height/2+height/3-size2) {
        speedY2 = speedY2+1;
      } else {
        y2=height/2+height/3-size2;
        speedY2 = 0;
        if (flightPower2<(100+flightPowerUpgrade*20)) {
          flightPower2=flightPower2+0.1;
        }
      }

      if (y2<=y-size/2 && y2>=y-size*2 && x2>x-size-speedLeft && x2<x+size+speedRight && (!(key==' '))) {
        speedY2=0;
        y2=y-size;
        x2=x;
      }
      if (y<=y2-size/2 && y>=y2-size*2 && x>x2-size-speedLeft2 && x<x2+size+speedRight2 && (!(key==' '))) {
        speedY=0;
        y=y2-size2;
        x=x2;
      }
      
      

      if (speedRight2>0) {
        speedRight2 = speedRight2 -1;
      }
      if (speedLeft2>0) {
        speedLeft2 = speedLeft2 -1;
      }

      if (x2<0) {
        x2++;
        speedLeft2=0;
      }

      if (x2>width-size2/2) {
        x2=x2-1;
        speedRight2=0;
      }

      for (int i = 0; i < 30; i++) {
        spikeArray[i].collision(x2, y2);
      }
      for (int i = 0; i < 100; i++) {
        fireballArray[i].collision(x2, y2);
      }
      for (int i = 0; i < 30; i++) {
        coinArray[i].collision(x2, y2);
      }
      for (int i = 0; i < 10; i++) {
        poisonSpikeArray[i].collision(x2, y2);
      }
    }

    fill(0);
    rect(0, height/2+height/3, width, height, 7);

    if (y<height/2+height/3-size) {
      speedY = speedY+1;
    } else {
      y=height/2+height/3-size;
      speedY = 0;
      if (flightPower<(100+flightPowerUpgrade*20)) {
        flightPower=flightPower+0.1;
      }
    }

    if (dead==true) {    
      clicked="";
      menuScreen=true;
      restart();
    }



    if (clicked=="multiplayer") {

      if (keyPressed) {
        char pressed=key;
        switch(pressed) {

        case 'd':
          if (speedRight<speedXMax) {
            speedRight=speedRight+2;
          }
          break;      
        case 'a':
          if (speedLeft<speedXMax) {
            speedLeft=speedLeft+2;
          }
          break;
        case 'w':
          if (speedY>speedYMin && flightPower>1) {  
            speedY=speedY-2;
            flightPower = flightPower -1;
          }
          break;

          //case ESC: 
          //exit();

        case CODED:
          int kc=keyCode;
          switch(kc) {
          case UP:
            if (speedY2>speedYMin2 && flightPower2>1) {
              speedY2=speedY2-2;
              flightPower2 = flightPower2 -1;
            }
            break;
          case LEFT: 
            if (speedLeft2<speedXMax2) {
              speedLeft2=speedLeft2+2;
            }
            break;
          case RIGHT:
            if (speedRight2<speedXMax2) {
              speedRight2=speedRight2+2;
            }
            break;
          }
        }
      }
    } else {

      if (keyPressed) {
        if (key=='d' && speedRight<speedXMax) {
          speedRight=speedRight+2;
        }

        if (key=='a' && speedLeft<speedXMax) {
          speedLeft=speedLeft+2;
        }

        if (key=='w' && speedY>speedYMin && flightPower>1) {  
          speedY=speedY-2;
          flightPower = flightPower -1;
        }

        //if(key==ESC) {
        //exit();
        //}
        if (key==CODED) {
          if (keyCode==UP && speedY>speedYMin && flightPower>1) {
            speedY=speedY-2;
            flightPower = flightPower -1;
          }

          if (keyCode==LEFT && speedLeft<speedXMax) {
            speedLeft=speedLeft+2;
          }

          if (keyCode==RIGHT && speedRight<speedXMax) {
            speedRight=speedRight+2;
          }
        }

        if (key==' ' && speedY>speedYMin && flightPower>1) {
          speedY=speedY-2;
          flightPower = flightPower -1;
        }
      }
    }


    if (speedRight>0) {
      speedRight = speedRight -1;
    }
    if (speedLeft>0) {
      speedLeft = speedLeft -1;
    }

    if (x<0) {
      x++;
      speedLeft=0;
    }

    if (x>width-size/2) {
      x=x-1;
      speedRight=0;
    }

    for (int i = 0; i < 30; i++) {
      spikeArray[i].display();
      spikeArray[i].move();
      spikeArray[i].collision(x, y);
    }
    for (int i = 0; i < 100; i++) {
      fireballArray[i].display();
      fireballArray[i].move();
      fireballArray[i].collision(x, y);
    }
    for (int i = 0; i < 30; i++) {
      coinArray[i].display();
      coinArray[i].move();
      coinArray[i].collision(x, y);
    }
    for (int i = 0; i < 10; i++) {
      poisonSpikeArray[i].display();
      poisonSpikeArray[i].move();
      poisonSpikeArray[i].collision(x, y);
    }
    for (int i = 0; i < 10; i++) {
      cloudArray[i].display();
      cloudArray[i].move();
    }

    //goldenCloudArray[1].display();
    //goldenCloudArray[1].move();
    //goldenCloudArray[1].collision();


    levelCheck(pcFake); //Checks the level, updates level if passed 4200 pixels

    if (restart==true) {
      restart=false;
    }
  }
  if (clicked=="tutorial") {
    
    if (y<height/2+height/3-size) {
      speedY = speedY+1;
    } else {
      y=height/2+height/3-size;
    }

    if (speedRight>0) {
      speedRight = speedRight -1;
    }
    if (speedLeft>0) {
      speedLeft = speedLeft -1;
    }

    x=x+speedRight-speedLeft-ss;
    y=y+speedY;

    
    
    background(80, 80, 255);
    textSize(32);
    fill(0);
    text("No Multitasking!", width/2-width/8.7, height/2-height/2.5);
    switch(stage) {
    case 0:
      ss=0;
      if(ts) {
        text("Hey!!! You've already got the tutorial skin!", width/2-200, height/2);
      }
      else {
        stage++;
        x=width/2;
        y=height/2;
      }
      break;
    case 1:
      text("Just get used to the controls! Press space when you're done with that.", 170, height/2);
      if(keyPressed && key==' ') {
        stage++;
        x=width/2;
        y=height/2;
      }
      break;

    case 2:
      text("Here's a spike! Jump over it and get to the edge of the sreen.", 170, height/2);
      spikeArray[1].display();
      spikeArray[1].move();
      spikeArray[1].collision(x, y);
      if(x>width) {
        stage++;
        x=width/2;
        y=height/2;
      }
      break;
    case 3:
      text("Now let's add a fireball!!!",width/2-200, height/2);
      spikeArray[1].display();
      spikeArray[1].move();
      spikeArray[1].collision(x, y);
      fireballArray[1].display();
      fireballArray[1].move();
      fireballArray[1].collision(x, y);
      if(x>width) {
        stage++;
        x=width/2;
        y=height/2;
      }
      break;
      
      case 4:
        text("Let's spice it up a bit and get things moving!",width/2-350, height/2);
        ss=1;
        level=1;
        for (int i = 0; i < 30; i++) {
          spikeArray[i].display();
          spikeArray[i].move();
          spikeArray[i].collision(x, y);
        }
        for (int i = 0; i < 100; i++) {
          fireballArray[i].display();
          fireballArray[i].move();
          fireballArray[i].collision(x, y);
        }
        for (int i = 0; i < 10; i++) {
          poisonSpikeArray[i].display();
          poisonSpikeArray[i].move();
          poisonSpikeArray[i].collision(x, y);
        }
        if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
        if(x<0) {
          dead=true;
        }
        break;
     case 5:
       text("Good job now you're a pro at this! Now go and play the game for real!",width/2-600,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 6:
       text("you can go now...",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 7:
       text("Just leave!",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
    case 8:
       text("You really can just go",width/2-200,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 9:
       text("The menu button is right up there...",width/2-300,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 10:
       text("I promise there's nothing special over there",width/2-350,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 11:
       text("See! There's nothing here!",width/2-200,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 12:
       text("Just stop!!!",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 13:
       text("Please",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 14:
       text("Fine!",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 15:
       text("Now try to get past",width/2-100,height/2);
       ss=5;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
      case 16:
       text("How did you do that???",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
      case 17:
       text("I'm just leaving",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 18:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 19:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 20:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 21:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 22:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 23:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 24:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 25:
       text("Bye",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 26:
       text("Wow! You are stubborn!",width/2-200,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 27:
       text("Really?!?!",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 28:
       text("Just stop.",width/2-100,height/2);
       ss=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 29:
       text("Now i'm mad!",width/2-100,height/2);
       ss=4;
       level=10;
       for (int i = 0; i < 100; i++) {
          fireballArray[i].display();
          fireballArray[i].move();
          fireballArray[i].collision(x, y);
       }
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
     case 30:
       text("Super hard mode!",width/2-150,height/2);
       ss=2;
       level=20;
       for (int i = 0; i < 100; i++) {
          fireballArray[i].display();
          fireballArray[i].move();
          fireballArray[i].collision(x, y);
       }
       for (int i = 0; i < 30; i++) {
          spikeArray[i].display();
          spikeArray[i].move();
          spikeArray[i].collision(x, y);
        }
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 31:
       text("I'm actually impressed!",width/2-200,height/2);
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 32:
       text("What are you doing this for?",width/2-200,height/2);
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 33:
       text("Now you can't fly!!!",width/2-200,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 34:
       text("Fireballs!",width/2-100,height/2);
       y=height/2+height/3.5;
       ss=1;
       level=4;
       for (int i = 0; i < 100; i++) {
          fireballArray[i].display();
          fireballArray[i].move();
          fireballArray[i].collision(x, y);
       }
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
       }
       break;
       case 35:
       text("Try to jump over a simple spike!",width/2-350,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       spikeArray[1].display();
       spikeArray[1].move();
       spikeArray[1].collision(x, y);
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 36:
       text("I new it!!! You are cheating!",width/2-350,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 37:
       text("You don't need this tutorial! You already have spike powers!",width/2-450,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 38:
       text("You also probably have a fireball sheild too!",width/2-300,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 39:
       text("The end of this dialog is soon...",width/2-300,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 40:
       text("I would try to stop you from getting to the end but you'll probably just cheat agian.",width/2-600,height/2);
       y=height/2+height/3.5;
       ss=0;
       level=0;
       if(x>width) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 41:
       text("Thanks for being so determined to get this far. This is all you get! Nothing!",width/2-500,height/2);
       ss=0;
       level=0;
       if(y<0) {
          stage++;
          x=width/2;
          y=height/2;
        }
       break;
       case 42:
       text("You're smart, so you get the tutorial skin!",width/2-300,height/2);
       ts=true;
       break;
    }
    
    if(ts) {
      fill(0);
      rect(x-size/3.8,y-size/4,size/3.8+size+size/3.8,size/4,15);
      rect(x+size/6,y-size*1.5,size-size/6-size/6,size*1.5,8);
    }

    fill(230, 100, 255);
    rect(x, y, size, size, 10);

    fill(0);
    ellipse(x+size/4, y+size/4, size/3.5, size/3.5);
    ellipse(x+(size/4)*3, y+size/4, size/3.5, size/3.5);

    fill(255, 0, 0);
    triangle(x+size/4, y+size/2, x+size/2, y+size/1.1, x+(size/4)*3, y+size/2);

    fill(0);
    rect(0, height/2+height/3, width, height, 7);

    fill(tf);
    rect(10, 10, 80, 40, 20);            
    textSize(24);
    fill(150);
    text("Menu", 20, 40);
    if (mouseX>10 && mouseX<80 && mouseY>10 && mouseY<40) {
      tf=100;
      if (mousePressed==true) {
        background(255);
        clicked="";
        menuScreen=true;
        x=width/2;
        y=height/2;
        restart();
        stage=0;
      }
    } else {
      tf=0;
    }

    if (dead==true) {
      x=width/2;
      speedLeft=0;
      speedRight=0;
      y=height/2;
      speedY=0;
      dead=false;
    }


    if (keyPressed) {
      if (key=='d' && speedRight<speedXMax) {
        th = false;
        speedRight=speedRight+2;
      }

      if (key=='a' && speedLeft<speedXMax) {
        th = false;
        speedLeft=speedLeft+2;
      }

      if (key=='w' && speedY>speedYMin) {  
        th = false;
        speedY=speedY-2;
      }
      if (key==' ' && th==false) {
        //stage=stage+1; 
        //th = true;
      }

      if (key==CODED) {
        th = false;
        if (keyCode==UP && speedY>speedYMin) {
          speedY=speedY-2;
        }

        if (keyCode==LEFT && speedLeft<speedXMax) {
          speedLeft=speedLeft+2;
        }

        if (keyCode==RIGHT && speedRight<speedXMax) {
          speedRight=speedRight+2;
        }
      }
    }
  }

  if (y>height/2+height/3-size) {
    speedY = 0;
  }
}



/*void keyPressed() {
 if (value == 0) {
 value = 255;
 } else {
 value = 0;
 }
 }*/


class spike {
  float x;
  float y;
  int oldSize;
  int size;
 
  spike() {
  }
  spike(int sx, int sy, int sSize) {
    x = sx;
    y = sy;
    oldSize = sSize;
  }
  public void display() {
    size=oldSize+level;
    fill(100);
    triangle(x, y, x+size/2, y-size, x+size, y);
    if(stage==0) {
      if(spikeTime>0) {
        fill(0);
        rect(width/2-spikeTime/2,10,spikeTime,50);
      }
      fill(0);
      text("Spike Powers:" + spikePower, 20, 30);
    }
  }
  public void move() {
    x = x-ss;   
    if (x<0 && !(stage==35)) {
      if(level==0) {
        //???  
      }
      else {
        if (round(random(1, 4200/level)) == 1 && (!(level==10))) {
          x=width;
        }
      }
    }
    if(rs==true) {
      x=-size*10;
      if(level==10) {
        rs=false;  
      }
    }
    if (restart==true) {
      x=0-size*10;
    }
    if (stage==2 || stage==3 || stage==35) {
      x=width/2+300;
    }
    if(stage==34) {
      spikeTime=0;  
    }
    if(key=='1' && keyPressed && spikePower>0 && noSpikes==false) {
      spikePower--;
      noSpikes=true;
      spikeTime=800;
    }
    if(noSpikes) {
      if(spikeTime>0) {
        x=-size*10;
        spikeTime-=0.03;
      }
      else {
        noSpikes=false;
      }
    }
  }

  void collision(float cx, float cy) {
    float dist = dist(cx+42/2, cy+42/2, x+size/2, y+size/2);
    if (dist<=size+42/2) { //42 is the size of the player
      dead = true;
    }
  }
}

class poisonSpike extends spike {

  poisonSpike() {
  }

  poisonSpike(int x, int y, int size) {
    super(x, y, size);
  }
  void display() {
    size=oldSize+level;
    fill(86, 163, 50);
    triangle(x, y, x+size*1.5, y-size*3, x+size*3, y);
  }
  void collision(int cx, int cy) {
    float dist = dist(cx+42/2, cy+42/2, x+size*1.5, y+size*1.5);
    if (dist<=size*3+42/2) { //42 is the size of the player
      dead = true;
      coin = coin - coin/4;
      fireballSheild = false;
    }
  }
}



class fireball {
  float fx;
  float fy;
  float fxs; //fxs = fireball X Speed
  float fys; //fxy = fireball Y Speed
  int fsize;
  float px;
  float py;
  boolean fireballHelp = false;

  fireball() {
  }

  fireball(int fireballx, int firebally, int fireballsize) {
    fx=fireballx;
    fy=firebally;
    fsize=fireballsize;
    px=x;
  }

  public void display() {
    fill(255, 100, 25);
    ellipse(fx, fy, fsize, fsize);
  }

  public void move() {
    fx=round(fx+fxs);
    fy=round(fy+fys);

    if (fireballHelp==false) {


      if (fx<x) {
        float c=x-fx;
        if (fxs<c/20) {
          fxs=fxs+c/100;
        } else {
          fxs=fxs-c/100;
        }
      } else {
        float d=fx-x;
        if (fxs<d/20) {
          fxs=fxs-d/100;
        } else {
          fxs=fxs-d/100;
        }
      }
      if (fy>(height/2+height/3)) {
        if (fy>=(height+fsize)) {
          if(!(stage==3)) {
            if (round(random(1, 30000/level))==1 && !(level==10)) {
              fy=0;
              fx=round(random(1, width));
            }
          }
          else {
            fy=0;
            fx=round(random(1, width));
            fxs=0;
            fys=0;
          }
        } else {
          fy=height+fsize+1;
        }
      } else {
        float b=dist(fx, fy, x, y);
        fys=fys+(b/10000);
      }

      if (restart==true) {
        fy=height+fsize+1;
      }
    } else {
      fxs=0-fxs;
      fys=0-fys/1.5;
      for (int i=0; i<size; i++) {
        fy=fy-1;
      }
      fireballHelp=false;
    }
  }

  void collision(float cx, float cy) {
    float dist = dist(cx+size/2, cy+size/2, fx, fy);
    if (dist<=fsize+42/2) {
      if (fireballSheild==false) {
        dead = true;
      } else {
        fireballHelp=true;
      }
    }
  }
}

class button {
  int x;
  int y;
  int l;
  int h;
  int fill=0;
  int wl;
  int textx;
  String text;
  button() {
  }

  button(int bx, int by, int bl, int bh, int tx, String btext) {
    x=bx;
    y=by;
    l=bl;
    h=bh;
    text=btext;
    textx=tx;
  }
  void display() {
    fill(fill);
    rect(x, y, l, h, 7);
    textSize(50);
    fill(200);
    wl=text.length();
    text(text, textx, y+h/1.5);
  }

  void clicked() {
    if (menuScreen==true) {
      if (mouseX>=x && mouseY>=y && mouseX<=x+l && mouseY<=y+h) {
        fill=100;
        if (mousePressed==true) {
          clicked = text;
          dead=false;
          pcReal = 0;
        }
      } else {
        fill=0;
      }
    }
  }
}

class coin {
  float x;
  float y;
  int size;
  coin() {
  }
  coin(int cx, int cy, int csize) {
    x=cx;
    y=cy;
    size=csize;
  }
  void display() {
    fill(255, 255, 0);
    ellipse(x, y, size, size);
  }
  void move() {
    x=x-ss; 
    if ((x<0 && round(random(1, 10000/(coinUpgrade+1))) == 1)) {
      x=width;
      y=round(random(height/2+height/3-50, 50));
    }
    if (restart==true) {
      x=0-size*10;
    }
  }
  void collision(float playerX, float playerY) {
    float dist = dist(playerX+42/2, playerY+42/2, x, y); //42 is the size of the player
    if (dist<=size+42/2) { 
      coin=coin+1;
      x=0-size;
    }
  }
}

class cloud {
  int cx;
  int cy;
  int size;
  int speed;
  int random;
  int times = 2;
  float col = random(100,255);
  cloud() {
  }
  cloud(int cloudx, int cloudy, int csize) {
    cx= round(random(cloudx-csize, cloudx+csize*2));
    cy= round(random(cloudy-csize*2, cloudy+csize));
    size=round(random(csize/2, csize*1.5));
    speed=round(random(0-40/size, 40/size));
    random=1;
  }
  void display() {
    fill(255);
    stroke(255);
    if(level==10) {     
      fill(col,0,0);
      stroke(col,0,0);
    }
    for (int i=0; i<size/2; i++) {
      ellipse(cx+i*(size/4), cy, size, size);
    }
    stroke(0);
  }
  void move() {
    cx=cx-round(ss-random(speed/2, speed*1.5));
    if(level==10 && speed==0 || speed==-0) {
      speed=1;    
    }
    if (cx<0-size*times) {
      if (round(random(1, random))==1) {
        cx=width;
      }
    }
    if (restart==true) {
      cx=round(random(0, width)); 
      cy= round(random(0, height/2));
      speed=round(random(0-40/size, 40/size));
    }
  }
}

class goldenCloud extends cloud {

  goldenCloud() {
  }
  goldenCloud(int cx, int cy, int size) {
    super(cx, cy, size);
    random=100;
    coinArray[1] = new coin(round(cx+size*5), cy-size-20, 20);
    coinArray[2] = new coin(round(cx+size*2.5), cy-size-20, 20);
    coinArray[3] = new coin(round(cx+size*1), cy-size-20, 20);
    times=5;
    speed=0;
  }
  void collision() {    
    if (x>cx-size/1.2 && x<cx+size*5 && y>cy-50 && y<cy) {
      speedY=0;
    }
  }
  void display() {
    fill(239, 239, 91);
    stroke(209, 209, 51);
    rect(cx, cy, size*5, size, 20);
    stroke(0);
  }
}

void restart() {
  //player.rewind();
  //player.pause();
  restart=true;
  speedRight = 0;
  speedLeft = 0;
  speedYMin = -10;
  speedY = 0;

  x2= width/2;
  y2= height/2-height/3;
  size2=42;
  speedRight2 = 0;
  speedLeft2 = 0;
  speedXMax2 = 10;
  speedYMin2 = -10;
  speedY2 = 0;
  flightPower2 = 100;
  spikePower=oldSpikePower;
  spikeTime=0;

  flightPower=100+flightPowerUpgrade*20;
  flightPower2=100+flightPowerUpgrade*20;
  ss = 1; //ss = screenSpeed
  pcFake = 0; //pc = pixelCount
  level = 1;
  x = width/2;
  y = height/2;
  size = 42;
  
  stage=0;
  
  rs=false;
}

void levelCheck(float pcF) {
  if (pcF>=1000) { 
    pcFake=0;
    level=level+1;
    coin=coin+level;
  }
}

class bossBattle {
  int bbsize;
  int bbx;
  int bby;
  int bySpeed;
  int jumpTime=0;
  float bxSpeed;
  int bxms=4;
  float health=100;
  boolean stage1 = true;
  boolean jump = false;
  bossBattle() {
  }
  bossBattle(int bossX, int bossY, int bossS) {
    bbx=bossX;
    bby=bossY;
    bbsize=bossS;
  }
  void display() {
    //print("hi");
    strokeWeight(3.8);
    fill(230, 100 , 255);
    rect(bbx, bby, bbsize, bbsize, 10);

    fill(0);
    ellipse(bbx+bbsize/4, bby+bbsize/4, bbsize/3.5, bbsize/3.5);
    ellipse(bbx+(bbsize/4)*3, bby+bbsize/4, bbsize/3.5, bbsize/3.5);
  
    fill(255, 0, 0);
    triangle(bbx+bbsize/4, bby+bbsize/1.1, bbx+bbsize/2, bby+bbsize/2, bbx+(bbsize/4)*3, bby+bbsize/1.1);
    
    fill( ((100-health)/100)*255 , health/100*255 , 0);
    rect(bbx+(bbx-health/100*(bbsize-bbsize/5))/2-(bbsize/10*7)/2,bby-bbsize/6.5,health/100*(bbsize-bbsize/5),10);
    
    strokeWeight(1);
    
    
  }
  void move() {
    bby+=bySpeed;
    bbx+=round(bxSpeed);
    if(bby<height/2+height/3-bbsize) {
      bySpeed++;  
    }
    else {
      bySpeed=0;
      bby=height/2+height/3-bbsize;                                                                                                                                                                                             
    }
    
    if(health<0) {
      level++;  
    }
    
    //ai:
    jumpTime++;
    if(jumpTime>500) {
      jumpTime=-200;
      jump=true;  
    }
    
    if(jump) {
      jump=false;
      bySpeed=-100;
    }
       
    if(bby+size<0) {
      fill(0);
      ellipse(bbx+bbsize/2,80,(-bby)/50,(-bby)/50);
      if (bbx<x) {
        float c=x-bbx;
        if (bxSpeed<c/20) {
          bxSpeed=bxSpeed+c/100;
        } else {
          bxSpeed=bxSpeed-c/100;
        }
      } else {
        float d=bbx-x;
        if (bxSpeed<d/20) {
          bxSpeed=bxSpeed-d/100;
        } else {
          bxSpeed=bxSpeed-d/100;
        }
      }
    }
    
    if(bby+bbsize>0 && bySpeed>20) {
      bySpeed=20;
      bxSpeed/=1.1;
    }
  }
  void collision(float px,float py, float psl, float psr , float psy, float psize) {
    if(px+psize>bbx && px<bbx+bbsize && py+psize>bby && py<bby+bbsize) {
      if(py>bby+(bbsize/2) && px>bbx+psize/2 && px<bbx-psize/2) {
        dead=true;      
      }
      else {
        if(psr>psl) {
          health-=psr/4+psy/5;
          speedLeft=round(speedRight*1.5);
        }
        else {
          health-=psl/4+psy/5;
          speedRight=round(speedLeft*1.5);
        }
        
        speedY=-round(speedY/1.5);
        y+=speedY;
        y--;
                
      }
    }
  }
}