// No Multitasking!


int value = 0; 
int stage = 1;

// Main character initial vars
int x; 
int y;
int size;
int speedRight = 0;
int speedLeft = 0;
int speedXMax = 10; 
int speedYMin = -10; //Charatcer can control going up, so there's a min. But the chracter can't control going down, so there's no need for a max.
int speedY = 0; //Gravitional force
float flightPower = 100; //Jet pack fuel

// 2nd character initial vars 
int x2;
int y2;
int size2;
int speedRight2 = 0;
int speedLeft2 = 0;
int speedXMax2 = 10;
int speedYMin2 = -10;
int speedY2 = 0;
float flightPower2 = 100;

//Feild Movement
int ss = 1; //ss = screenSpeed
int pcFake = 0; //pc = pixelCount, used to check when to change level
int pcReal = 0; //pc = pixelCount, used to tell how many pixels the chracter travled

//Game vars
int level = 1; 
int coin = 0;
boolean dead = false;
boolean restart = false;

//Vars for shop
boolean clickHelp = false; //limits mousePressed events to one time
//sfill is to highlight the menu button as well as the chracters when hovered over.
//a,b,c = r,g,b
int sfill = 0; //sfill = storeFill, for menu button, base color

int sfill2a = 230; //sfill2 is for speedboost
int sfill2b = 100;
int sfill2c = 255;

int sfill3a = 230; //sfill3 is for more coin upgrade
int sfill3b = 100;
int sfill3c = 255;
int coinUpgrade = 0; //counting amount of coin upgrades

int sfill4a = 230; //sfill4 is for more flightpower
int sfill4b = 100;
int sfill4c = 255;
int flightPowerUpgrade=0; //counting amount of flightpower upgrades

int sfill5a = 230; //sfill5 is for a fireball sheild
int sfill5b = 100;
int sfill5c = 255;
boolean fireballSheild = false;

//tutorial vars
int tf = 0; //tf = tutorial fill menu button color

//boolean spikeSheild = false; in development
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

void setup() {
  fullScreen();
  background(255);
  x = width/2;
  y = height/2;
  size = 42;
  x2 = width/2;
  y2 = height/2;
  size2 = 42;
  
  for(int i = 0;i < 30;i++){
    spikeArray[i] = new spike(0-20*3,height/2+height/3,20);
  }
  for(int i = 0;i < 100;i++){
    fireballArray[i] = new fireball(round(random(1,width)),height-50,20);
  }
  for(int i = 0;i < 30;i++){
    coinArray[i] = new coin(0,round(random(height/2+height/3-50,50)),20);
  }
  for(int i = 0;i < 10;i++){
    poisonSpikeArray[i] = new poisonSpike(0-20*3,height/2+height/3,20);
  }
  for(int i = 0;i < 10;i++){
    cloudArray[i] = new cloud(round(random(0,width)),round(random(0,height/2)),20);
  }
    buttonArray[1] = new button(width/2-210,height/2-100,340,75,width/2-105,"play");
    buttonArray[2] = new button(width/2-210,height/2+100,340,75,width/2-115,"store");
    buttonArray[3] = new button(width/2-210,height/2,340,75,width/2-180,"multiplayer");
    buttonArray[4] = new button(width/2-210,height/2+200,340,75,width/2-140,"tutorial");
    
    //goldenCloudArray[1] = new goldenCloud(width/2,round(random(height/4,height/2)),50);
    
}

void draw() {
  
  background(255,0,255);
  if(dead==true) {
    fill(0);
    textSize(32);
    text("YOU LOSE", width/2-width/12,height/1.15);
    String a = ""+round(pcReal-width/2+x);
    int z = a.length();
    text("You travelled "+a+" pixels.", width/2-width/8-(z*16),height/1.05);
  }
  textSize(32);
  fill(0);
  text("No Multitasking!", width/2-width/8.7,height/2-height/2.5);
  

    buttonArray[1].display();
    buttonArray[1].clicked();
    buttonArray[2].display();
    buttonArray[2].clicked();
    buttonArray[3].display();
    buttonArray[3].clicked();
    buttonArray[4].display();
    buttonArray[4].clicked();
  
  
  if (clicked=="store") {
      
      menuScreen=false;
      int dx = width/2-70; //dx = drawing x
      int dy = height/2; //dy = drawing y
      
      background(255,255,200);
    
      textSize(32);
      fill(0);
      text("No Multitasking!", width/2-width/8.7,height/2-height/2.5);
      textSize(24);
      text("Coins:"+coin,width-120,height/2-height/2.5);
      text("Speedboost $20",dx-70,dy+size+30);
      text("More Flight Power $25",dx-100,dy-size*4-20);
      text("More Coins $30",dx-70,dy+size+30+size*4);
      text("Fireball Sheild $100",dx-90,dy+size+30+size*7);
      
      fill(sfill);
      rect(10,10,80,40,20);            
      textSize(24);
      fill(150);
      text("Menu",20,40);
      if(mouseX>10 && mouseX<80 && mouseY>10 && mouseY<40) {
        sfill=100;
        if(mousePressed==true) {
          background(255);
          clicked="";
          menuScreen=true;
        }
      }
      else {
        sfill=0; 
      }

      fill(sfill2a,sfill2b,sfill2c);
      rect(dx,dy,size,size,10);
  
      fill(0);
      ellipse(dx+size/4,dy+size/4,size/3.5,size/3.5);
      ellipse(dx+(size/4)*3,dy+size/4,size/3.5,size/3.5);
  
      fill(255,0,0);
      triangle(dx+size/4,dy+size/2,dx+size/2,dy+size/1.1,dx+(size/4)*3,dy+size/2);  
    
      noFill();
      arc(dx-size/4,dy,size,size,PI/2,PI);
      arc(dx-size/4,dy+size/2,size,size,PI/2,PI);
      arc(dx-size/4,dy+size/4,size,size,PI/2,PI);
      
      
      if(coin>19) {
      if(mouseX>dx && mouseX<dx+size && mouseY>dy && mouseY<dy+size && clickHelp==false) {
        sfill2a=270;
        sfill2b=140;
        sfill2c=255;
        if(mousePressed==true) {
          coin=coin-20;
          speedXMax=speedXMax+5;
          sfill2a=270;
          sfill2b=140;
          sfill2c=255;
          if(mousePressed==true) {
            clickHelp=true;
            sfill2a=270;
            sfill2b=140;
            sfill2c=255;
          }
        }
      }   
      else {
        sfill2a=230;
        sfill2b=100;
        sfill2c=255;        
      }
      }
      else {
        sfill2a=128;
        sfill2b=128;
        sfill2c=128;  
      }
      
      if(coin>29) {
      if(mouseX>dx && mouseX<dx+size && mouseY>dy+size*4 && mouseY<dy+size+size*4 && clickHelp==false) {
        sfill3a=270;
        sfill3b=140;
        sfill3c=255;
        if(mousePressed==true) {
          coin=coin-30;
          coinUpgrade=coinUpgrade+4;
          sfill3a=270;
          sfill3b=140;
          sfill3c=255;
          if(mousePressed==true) {
            clickHelp=true;
            sfill3a=270;
            sfill3b=140;
            sfill3c=255;
          }
        }
      }
      else {
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
      
      if(coin>24) {
      if(mouseX>dx && mouseX<dx+size && mouseY>dy-size*4 && mouseY<dy+size-size*4 && clickHelp==false) {
        sfill4a=270;
        sfill4b=140;
        sfill4c=255;
        if(mousePressed==true) {
          coin=coin-25;
          flightPowerUpgrade=flightPowerUpgrade+1;
          flightPower=flightPower+20;
          sfill4a=270;
          sfill4b=140;
          sfill4c=255;
          if(mousePressed==true) {
            clickHelp=true;
            sfill4a=270;
            sfill4b=140;
            sfill4c=255;
          }
        }
      }
      else {
        sfill4a=230;
        sfill4b=100;
        sfill4c=255;        
      }
      }
      else {
        sfill4a=128;
        sfill4b=128;
        sfill4c=128; 
      }
      
      if(coin>99) {
      if(mouseX>dx && mouseX<dx+size && mouseY>dy+size*7 && mouseY<dy+size+size*7 && clickHelp==false) {
        sfill5a=270;
        sfill5b=140;
        sfill5c=255;
        if(mousePressed==true && fireballSheild==false) {
          coin=coin-100;
          fireballSheild = true;
          sfill5a=270;
          sfill5b=140;
          sfill5c=255;
          if(mousePressed==true) {
            clickHelp=true;
            sfill5a=270;
            sfill5b=140;
            sfill5c=255;
          }
        }
      }
      else {
        sfill5a=230;
        sfill5b=100;
        sfill5c=255;        
      }
      }
      else {
        sfill5a=128;
        sfill5b=128;
        sfill5c=128; 
      }
      
      
      if(mousePressed==false) {
        clickHelp=false; 
      }
      
      fill(sfill3a,sfill3b,sfill3c);
      rect(dx,dy+size*4,size,size,10);
  
      fill(0);
      ellipse(dx+size/4,dy+size/4+size*4,size/3.5,size/3.5);
      ellipse(dx+(size/4)*3,dy+size/4+size*4,size/3.5,size/3.5);
  
      fill(255,0,0);
      triangle(dx+size/4,dy+size/2+size*4,dx+size/2,dy+size/1.1+size*4,dx+(size/4)*3,dy+size/2+size*4);
      
      fill(255,255,0);
      ellipse(dx+size,dy+size*4,20,20);
      ellipse(dx-size/4,dy+size*5,20,20);
      ellipse(dx-size/3,dy+size*4.5,20,20);
      ellipse(dx+size/1.3,dy+size*3.5,20,20);
      ellipse(dx+size,dy+size*4.8,20,20);
      ellipse(dx-size/3,dy+size*3.8,20,20);
      ellipse(dx+size/3.5,dy+size*3.5,20,20);
  
      
      
      fill(sfill4a,sfill4b,sfill4c);
      rect(dx,dy-size*4,size,size,10);
  
      fill(0);
      ellipse(dx+size/4,dy+size/4-size*4,size/3.5,size/3.5);
      ellipse(dx+(size/4)*3,dy+size/4-size*4,size/3.5,size/3.5);
  
      fill(255,0,0);
      triangle(dx+size/4,dy+size/2-size*4,dx+size/2,dy+size/1.1-size*4,dx+(size/4)*3,dy+size/2-size*4);
      
      fill(255,50,0);
      ellipse(dx+size/2,dy-size*4+size*1.2,size/3,size/3);
      ellipse(dx+size/4,dy-size*4+size*1.2,size/3,size/3);
      ellipse(dx+size/1.25,dy-size*4+size*1.2,size/3,size/3);
      fill(255,150,0);
      ellipse(dx+size/2,dy-size*4+size*1.5,size/3,size/3);
      ellipse(dx+size/4,dy-size*4+size*1.5,size/3,size/3);
      ellipse(dx+size/1.25,dy-size*4+size*1.5,size/3,size/3);
      fill(255,230,0);
      ellipse(dx+size/2,dy-size*4+size*1.8,size/3,size/3);
      ellipse(dx+size/4,dy-size*4+size*1.8,size/3,size/3);
      ellipse(dx+size/1.25,dy-size*4+size*1.8,size/3,size/3);
      fill(255,255,0);
      ellipse(dx+size/2,dy-size*4+size*2.1,size/3,size/3);
      
      
      fill(sfill5a,sfill5b,sfill5c);
      rect(dx,dy+size*7,size,size,10);
  
      fill(0);
      ellipse(dx+size/4,dy+size/4+size*7,size/3.5,size/3.5);
      ellipse(dx+(size/4)*3,dy+size/4+size*7,size/3.5,size/3.5);
  
      fill(255,0,0);
      triangle(dx+size/4,dy+size/2+size*7,dx+size/2,dy+size/1.1+size*7,dx+(size/4)*3,dy+size/2+size*7);
      
      noFill();
      arc(dx+size/2,dy+size*6.8,size,size,PI,PI*2);
      
      fill(255,100,25);
      ellipse(dx+size*1.2,dy+size/2+size*6,20,20);
  }
  
  
  
  if(clicked=="play" || clicked=="multiplayer") {
    
  menuScreen=false;
  ss=round(0.5*level);
  pcFake = pcFake + ss;
  pcReal = pcReal + ss;
  x=x+speedRight-speedLeft-ss;
  y=y+speedY;
  background(80,80,255);
  textSize(32);
  fill(0);
  text("No Multitasking!", width/2-width/8.7,height/2-height/2.5);
  textSize(16);
  text("Press escape/esc to quit the game.",10,10,90,100);
  textSize(24);
  text("Level:"+level,width-120,height/2-height/2.18);
  if(clicked=="play") {
    text("Flight Power:"+round(flightPower),width-200,height/2-height/2.33);
    text("Coins:"+coin,width-120,height/2-height/2.5);
  }
  
  fill(230,100,255);
  rect(x,y,size,size,10);
  
  fill(0);
  ellipse(x+size/4,y+size/4,size/3.5,size/3.5);
  ellipse(x+(size/4)*3,y+size/4,size/3.5,size/3.5);
  
  fill(255,0,0);
  triangle(x+size/4,y+size/2,x+size/2,y+size/1.1,x+(size/4)*3,y+size/2);
  
  if(clicked=="multiplayer") {
    
    fill(0);
    textSize(24);
    text("Flight Power Player 1:"+round(flightPower),width-330,height/2-height/2.5);
    text("Flight Power Player 2:"+round(flightPower2),width-330,height/2-height/2.67);
    text("Coins:"+coin,width-120,height/2-height/2.33);
    
    x2=x2+speedRight2-speedLeft2-ss;
    y2=y2+speedY2;
    
    fill(255,255,0);
    rect(x2,y2,size2,size2,10);
  
    fill(0);
    ellipse(x2+size2/4,y2+size2/4,size2/3.5,size2/3.5);
    ellipse(x2+(size2/4)*3,y2+size2/4,size2/3.5,size2/3.5);
  
    fill(255,0,0);
    triangle(x2+size2/4,y2+size2/2,x2+size2/2,y2+size2/1.1,x2+(size2/4)*3,y2+size2/2); 
    
    if(y2<height/2+height/3-size2) {
      speedY2 = speedY2+1;
    }
    else {
      y2=height/2+height/3-size2;
      speedY2 = 0;
      if (flightPower2<(100+flightPowerUpgrade*20)) {
        flightPower2=flightPower2+0.1;
      }
    }
    
     if(y2<=y && y2>=y-size && x2>x-size && x2<x+size) {
       speedY2=0;
       y2=y2-1;
       x2=x2+speedRight-speedLeft;
     }
     if(y<=y2 && y>=y2-size && x>x2-size && x<x2+size) {
       speedY=0;
       y=y-1;
       x=x+speedRight2-speedLeft2;
     }
    
    if(speedRight2>0) {
      speedRight2 = speedRight2 -1; 
    }
    if(speedLeft2>0) {
      speedLeft2 = speedLeft2 -1; 
    }
  
    if(y2<0-size2/2 || x2<0-size2) {
      dead=true;
    }
  
    if(x2>width-size2/2) {
      x2=x2-1;
      speedRight2=0;
    }
    
    for(int i = 0;i < 30;i++){
     spikeArray[i].collision(x2,y2);
    }
    for(int i = 0;i < 100;i++){
     fireballArray[i].collision(x2,y2);
    }
    for(int i = 0;i < 30;i++){
     coinArray[i].collision(x2,y2);
    }
    for(int i = 0;i < 10;i++){
     poisonSpikeArray[i].collision(x2,y2);
    }
  }
  
  fill(0);
  rect(0,height/2+height/3,width,height,7);
  
  if(y<height/2+height/3-size) {
    speedY = speedY+1;
  }
  else {
    y=height/2+height/3-size;
    speedY = 0;
    if (flightPower<(100+flightPowerUpgrade*20)) {
      flightPower=flightPower+0.1;
    }
  }

  if(dead==true) {    
    clicked="";
    menuScreen=true;
    restart();
  }
  
    
    
  if(clicked=="multiplayer") {
      
    if(keyPressed) {
      char pressed=key;
      switch(pressed) {
        
      case 'd':
        if(speedRight<speedXMax) {
          speedRight=speedRight+2;
        }
        break;      
      case 'a':
        if(speedLeft<speedXMax) {
          speedLeft=speedLeft+2;
        }
        break;
      case 'w':
        if(speedY>speedYMin && flightPower>1) {  
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
            if(speedY2>speedYMin2 && flightPower2>1) {
              speedY2=speedY2-2;
              flightPower2 = flightPower2 -1;
            }
            break;
          case LEFT: 
            if(speedLeft2<speedXMax2) {
              speedLeft2=speedLeft2+2;
            }
            break;
          case RIGHT:
            if(speedRight2<speedXMax2) {
              speedRight2=speedRight2+2;
            }
            break;
      }
      }
    }
  }

  
  
  
  else {
    
    if(keyPressed) {
      if(key=='d' && speedRight<speedXMax) {
        speedRight=speedRight+2;
      }
    
      if(key=='a' && speedLeft<speedXMax) {
        speedLeft=speedLeft+2;
      }
    
      if(key=='w' && speedY>speedYMin && flightPower>1) {  
        speedY=speedY-2;
        flightPower = flightPower -1;
      }
    
      if(key==ESC) {
        exit();
      }
    if(key==CODED) {
      if(keyCode==UP && speedY>speedYMin && flightPower>1) {
          speedY=speedY-2;
          flightPower = flightPower -1;
      }
      
      if(keyCode==LEFT && speedLeft<speedXMax) {
        speedLeft=speedLeft+2;
      }
      
      if(keyCode==RIGHT && speedRight<speedXMax) {
        speedRight=speedRight+2;
      }
    }
    
    if(key==' ' && speedY>speedYMin && flightPower>1) {
      speedY=speedY-2;
      flightPower = flightPower -1;
    }
  } 
  }
  
  
  if(speedRight>0) {
    speedRight = speedRight -1; 
  }
  if(speedLeft>0) {
    speedLeft = speedLeft -1; 
  }
  
  if(y<0-size/2 || x<0-size) {
    dead=true;
  }
  
  if(x>width-size/2) {
    x=x-1;
    speedRight=0;
  }
  
  for(int i = 0;i < 30;i++){
     spikeArray[i].display();
     spikeArray[i].move();
     spikeArray[i].collision(x,y);
  }
  for(int i = 0;i < 100;i++){
     fireballArray[i].display();
     fireballArray[i].move();
     fireballArray[i].collision(x,y);
  }
  for(int i = 0;i < 30;i++){
     coinArray[i].display();
     coinArray[i].move();
     coinArray[i].collision(x,y);
  }
  for(int i = 0;i < 10;i++){
     poisonSpikeArray[i].display();
     poisonSpikeArray[i].move();
     poisonSpikeArray[i].collision(x,y);
  }
  for(int i = 0;i < 10;i++){
     cloudArray[i].display();
     cloudArray[i].move();
  }
  
  //goldenCloudArray[1].display();
  //goldenCloudArray[1].move();
  //goldenCloudArray[1].collision();
  
  
  levelCheck(pcFake); //Checks the level, updates level if passed 4200 pixels
  
  if(restart==true) {
    restart=false; 
  }
}
  if(clicked=="tutorial") {
    ss=0;
    
    if(y<height/2+height/3-size) {
      speedY = speedY+1;
    }
    else {
      y=height/2+height/3-size;
    }
       
    if(speedRight>0) {
      speedRight = speedRight -1; 
    }
    if(speedLeft>0) {
      speedLeft = speedLeft -1; 
    }
    
    x=x+speedRight-speedLeft-ss;
    y=y+speedY;
    
    background(80,80,255);
    textSize(32);
    fill(0);
    text("No Multitasking!", width/2-width/8.7,height/2-height/2.5);
    switch(stage) {
      case 1:
      text("Just get used to the controls! Press space when you're done with that.", 170,height/2);
      break;
      
      case 2:
      text("Here's a spike! Jump over it and get to the edge of the sreen.", 170,height/2);
      spikeArray[1].display();
      spikeArray[1].move();
      spikeArray[1].collision(x,y);
      break;
    }
    
    fill(230,100,255);
    rect(x,y,size,size,10);
  
    fill(0);
    ellipse(x+size/4,y+size/4,size/3.5,size/3.5);
    ellipse(x+(size/4)*3,y+size/4,size/3.5,size/3.5);
  
    fill(255,0,0);
    triangle(x+size/4,y+size/2,x+size/2,y+size/1.1,x+(size/4)*3,y+size/2);
        
    fill(0);
    rect(0,height/2+height/3,width,height,7);
    
    fill(tf);
    rect(10,10,80,40,20);            
    textSize(24);
    fill(150);
    text("Menu",20,40);
    if(mouseX>10 && mouseX<80 && mouseY>10 && mouseY<40) {
      tf=100;
      if(mousePressed==true) {
        background(255);
        clicked="";
        menuScreen=true;
        x=width/2;
        y=height/2;
      }
    }
    else {
      tf=0; 
    }
    
    if(dead==true) {
      x=width/2;
      speedLeft=0;
      speedRight=0;
      y=height/2;
      speedY=0;
      dead=false;
    }
    
    
    if(keyPressed) {
      if(key=='d' && speedRight<speedXMax) {
        th = false;
        speedRight=speedRight+2;
      }
    
      if(key=='a' && speedLeft<speedXMax) {
        th = false;
        speedLeft=speedLeft+2;
      }
    
      if(key=='w' && speedY>speedYMin) {  
        th = false;
        speedY=speedY-2;
      }
      if(key==' ' && th==false) {
        //stage=stage+1; 
        //th = true;
      }
    
    if(key==CODED) {
      th = false;
      if(keyCode==UP && speedY>speedYMin) {
          speedY=speedY-2;
      }
      
      if(keyCode==LEFT && speedLeft<speedXMax) {
        speedLeft=speedLeft+2;
      }
      
      if(keyCode==RIGHT && speedRight<speedXMax) {
        speedRight=speedRight+2;
      }
    }
    
  }
  }
  
   if(y>height/2+height/3-size) {
    speedY = 0;
   }
}



void keyPressed() {
  if (value == 0) {
    value = 255;
  } else {
    value = 0;
  }
}


  class spike {
      int x;
      int y;
      int oldSize;
      int size;
      
    spike() {
      
    }
    spike(int sx,int sy,int sSize) {
      x = sx;
      y = sy;
      oldSize = sSize;
    }
    public void display() {
      size=oldSize+level;
      fill(100);
      triangle(x,y,x+size/2,y-size,x+size,y);
    }
    public void move() {
      x = x-ss;   
      if(x<0 || restart==true) {
        if(round(random(1,4200/level)) == 1 || restart==true) {
          x=width;
        }
      }
      if(clicked=="tutorial") {
        x=width/2+size*4;
      }
    }
    
    void collision(int cx,int cy) {
      float dist = dist(cx,cy,x,y);
      if(dist<=size+42) { //42 is the size of the player
        dead = true;
      }
    }
    
  }
  
  class poisonSpike extends spike {
  
    poisonSpike() {
      
    }
    
    poisonSpike(int x,int y, int size) {
      super(x,y,size);
    }
    void display() {
      size=oldSize+level;
      fill(86,163,50);
      triangle(x,y,x+size*1.5,y-size*3,x+size*3,y);
    }
    void collision(int cx,int cy) {
      float dist = dist(cx,cy,x,y);
      if(dist<=size+42) { //42 is the size of the player
        dead = true;
        coin = coin - coin/4;
        fireballSheild = false;
      }
    }
  }
  
  
  
class fireball {
  int fx;
  int fy;
  float fxs; //fxs = fireball X Speed
  float fys; //fxy = fireball Y Speed
  int fsize;
  int px;
  int py;
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
      fill(255,100,25);
      ellipse(fx,fy,fsize,fsize);
    }
    
    public void move() {
      fx=round(fx+fxs);
      fy=round(fy+fys);
      
      if(fireballHelp==false) {
        
        
        if(fx<x) {
          float c=x-fx;
          if(fxs<c/20) {
            fxs=fxs+c/100;
          }
          else {
            fxs=fxs-c/100;
          }
        }
        else {
          float d=fx-x;
          if(fxs<d/20) {
            fxs=fxs-d/100;
          }
          else {
            fxs=fxs-d/100;
          }
        }
        if(fy>(height/2+height/3)) {
          if(fy>=(height+fsize)) {
            if(round(random(1,30000/level))==1) {
              fy=0;
              fx=round(random(1,width));
            }
          }
          else {
            fy=height+fsize+1;
          }
        }
        else {
          float b=dist(fx,fy,x,y);
          fys=fys+(b/10000);
        }
      
        if(restart==true) {
          fy=height+fsize+1; 
        }
      }
        
      
      
      else {
        fxs=0-fxs;
        fys=0-fys/1.5;
        for(int i=0; i<size; i++) {
          fy=fy-1; 
        }
        fireballHelp=false;
      }
    }

    void collision(int cx,int cy) {
      float dist = dist(cx+size/2,cy+size/2,fx,fy);
      if(dist<=fsize+42/2) {
        if(fireballSheild==false) {
          dead = true;
        }
        else{
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
    rect(x,y,l,h,7);
    textSize(50);
    fill(200);
    wl=text.length();
    text(text,textx,y+h/1.5);
  }
    
  void clicked() {
    if(menuScreen==true) {
    if(mouseX>=x && mouseY>=y && mouseX<=x+l && mouseY<=y+h) {
      fill=100;
      if(mousePressed==true) {
         clicked = text;
         dead=false;
         pcReal = 0; 
      }
    }
    else {
      fill=0; 
    }
  }
}
}

class coin {
  int x;
  int y;
  int size;
  coin() {
      
  }
  coin(int cx, int cy, int csize) {
    x=cx;
    y=cy;
    size=csize;
  }
  void display() {
    fill(255,255,0);
    ellipse(x,y,size,size);
  }
  void move() {
    x=x-ss; 
    if((x<0 && round(random(1,10000/(coinUpgrade+1))) == 1)) {
      x=width;
      y=round(random(height/2+height/3-50,50));
    }
    if(restart==true) {
      x=0-size; 
    }
  }
  void collision(int cx,int cy) {
    float dist = dist(cx,cy,x,y);
    if(dist<=size+42) { //42 is the size of the player
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
  cloud() {
    
  }
  cloud(int cloudx,int cloudy,int csize) {
    cx= round(random(cloudx-csize,cloudx+csize*2));
    cy= round(random(cloudy-csize*2,cloudy+csize));
    size=round(random(csize/2,csize*1.5));
    speed=round(random(0-40/size,40/size));
    random=1;
  }
  void display() {
    for(int i=0;i<size/2; i++) {
      fill(255);
      stroke(255);
      ellipse(cx+i*(size/4),cy,size,size);
      stroke(0);
    }
  }
  void move() {
    cx=cx-round(ss-random(speed/2,speed*1.5));
    if(cx<0-size*times) {
      if(round(random(1,random))==1) {
        cx=width;
      }
    }
    if(restart==true) {
      cx=round(random(0,width)); 
      cy= round(random(0,height/2));
      speed=round(random(0-40/size,40/size));
    }
  }
}

class goldenCloud extends cloud {
  
  goldenCloud() {
    
  }
  goldenCloud(int cx,int cy, int size) {
    super(cx,cy,size);
    random=100;
    coinArray[1] = new coin(round(cx+size*5),cy-size-20,20);
    coinArray[2] = new coin(round(cx+size*2.5),cy-size-20,20);
    coinArray[3] = new coin(round(cx+size*1),cy-size-20,20);
    times=5;
    speed=0;
  }
  void collision() {    
    if(x>cx-size/1.2 && x<cx+size*5 && y>cy-50 && y<cy) {
      speedY=0;
    }
  }
  void display() {
    fill(239,239,91);
    stroke(209,209,51);
    rect(cx,cy,size*5,size,20);
    stroke(0);
  }
}

void restart() {
  restart=true;
  value = 0;
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
  
  flightPower=100+flightPowerUpgrade*20;
  ss = 1; //ss = screenSpeed
  pcFake = 0; //pc = pixelCount
  level = 1;
  
  x = width/2;
  y = height/2;
  size = 42;
}

void levelCheck(int pcF) {
  if(pcF>=4200) { 
    pcFake=0;
    level=level+1;
  }
}