Particle[] bob = new Particle[150];

void setup(){
  size(640, 640);
  background(0);
  for(int i = 0; i < 10; i++){
    bob[i] = new Oddball();
  }
  for(int i = 10; i < bob.length; i++){
    bob[i] = new Particle();
  }
}

void draw(){
  background(0);
  for(int i = 0; i < bob.length; i++){
    bob[i].move();
    bob[i].show();
    bob[i].reset();
  }
  frameRate(40);
}

void mousePressed(){
  background(0);
  for(int i = 0; i < 10; i++){
    bob[i] = new Oddball();
    bob[i].move();
    bob[i].show();
    bob[i].reset();
  }
  for(int i = 10; i < bob.length; i++){
    bob[i] = new Particle();
    bob[i].move();
    bob[i].show();
    bob[i].reset();
  }
}

class Particle{
  float myX, myY, mySize;
  double myAngle, mySpeed;
  int myColor;
  Particle(){
    myX = 320;
    myY = 240;
    myAngle = Math.random() *2*Math.PI;
    mySpeed = Math.random() * 7 + 2;
    myColor = color((int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255)); 
    mySize = (float)(Math.random() + 3);
}
  void show(){
    noStroke();
    fill(myColor);
    float size = (float)mySize * dist(320, 240, myX, myY)/60;
    ellipse((float)myX, (float)myY, size, size);
  }
  void move(){
    myX = myX + (float)(Math.cos(myAngle) * mySpeed);
    myY = myY + (float)(Math.sin(myAngle) * mySpeed);
  }
  void reset(){
    if(myX > 640 || myY > 640 || myX < 0 || myY < 0){
      myX = 320;
      myY = 240;
      myAngle = Math.random() * 360;
      mySpeed = Math.random() * 7 + 2;
    }
  }
}

class Oddball extends Particle{
  float spinAngle, spinSpeed, respawnTime;
  Oddball(){
    myAngle = Math.random() *2*Math.PI;
    mySpeed = Math.random() * 7 + 2;
    spinAngle = (float)(Math.random() * 360);
    spinSpeed = (float)(Math.random() * 0.005) + 0.001; 
    respawnTime = (float)Math.random();
    myX = -100;
    myY = -100;
  }
  
  void show(){
    fill(255);
    pushMatrix();
    translate(width*0.8, height*0.5);
    rotate(frameCount / -100.0);
    star(myX, myY, 5, 10, 5); 
    popMatrix();
    spinAngle += spinSpeed;
  }
  
    void reset(){
    if(myX > 640 + respawnTime * 1000|| myY > 640 + respawnTime * 1000|| myX < 0 - respawnTime * 1000|| myY < 0 - respawnTime * 1000){
      myX = -100;
      myY = -100;
      myAngle = Math.random() * 360;
      mySpeed = Math.random() * 7 + 2;
      spinAngle = (float)(Math.random() * 360);
      spinSpeed = (float)(Math.random() * 0.005) + 0.001; 
      respawnTime = (float)Math.random();
    }
    }
}



void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
