import processing.video.*;
import java.awt.Point;
Capture cam;
PImage orimage; //original frame
int blobsize = 10;
PImage catness;
ArrayList<Point> catpixel;
int m;
float xlast = 320;
float ylast = 240;
float xplace;
float yplace;

void setup() {
  int fps = 30, w = 640, h = 480;
  cam = new Capture(this, w, h, fps);
  cam.start();
  size(cam.width,cam.height);
  catness = loadImage("cat.jpg");
  catpixel = new ArrayList<Point>();
}

void draw() {
  background(0);
  m = millis();
  if ( cam.available()) {
    cam.read();
    orimage = cam.get();
    blobdetect(orimage);
    //image(orimage,0,0);
    blobber(cam);
    catplace();
  }
  rectangles();
}

void blobdetect(PImage src){

  color black = color(0,0,0);

  for(int x = 0; x < src.width; x++) {
    for (int y = 0; y < src.height; y++) {
      color c = src.get(x,y);
      
      if (isColor(colorBlob, c)){
        cam.set(x,y,colorBlob);
      }
      else {
        cam.set(x,y,black);
      }
    }
  }
}

void blobber(PImage src) {
  color black = color (0,0,0);
  
  for(int x = 0; x < src.width; x++) {
    for (int y = 0; y < src.height; y++) {
      color c = src.get(x,y);
      
      if (c == colorBlob){
        
        int colorBlobcount = 0;
        
        for (int xl = x-blobsize; xl < x+blobsize; xl++) {
          for (int yl = y-blobsize; yl < y+blobsize; yl++) {
            color d = src.get(xl,yl);
            
            if (d == colorBlob){
              colorBlobcount++;
            }
          }
        }
        if (colorBlobcount > (blobsize*blobsize)/2) {
          
          catpixel.add(new Point(x,y));
        }
      }
    }
  }
}

void catplace() {
  
  xlast = xplace;
  ylast = yplace;
  
  xplace = 0;
  yplace = 0;
  
  
  int n = catpixel.size();
  for (int k = n - 1; k >= 0; k--) {
    Point p = catpixel.remove(k);
    xplace += p.x;
    yplace += p.y;
  }
  xplace /= n;
  yplace /= n;
  
  fill(255,255,0);
  noStroke();
  rect(width-xplace,yplace,30,90);
  
  println(xlast+","+ylast+"/,/"+xplace+","+yplace);
}

void rectangles() {
  /*float yrect = (m/4)%640;
  float xrect;
  if (yrect==0) {
    xrect = random(0,640);
  }*/
  fill(0,255,0);
  noStroke();
  rect(50,(m/4)%640,10,30);
}

boolean isColor(color orig, color c)
{
  return abs(red(c)   - red(orig))   < threshold && 
         abs(green(c) - green(orig)) < threshold && 
         abs(blue(c) - blue(orig))  < threshold;
}

color colorBlob = color(255,21,119);;
float threshold = 90;

/*void keyTyped()
{
  switch (key)
  {
    case 'q': //if (key == 'q') {
      colorBlob += 1 << 16; // red++
      break;
    case 'a': //if (key == 'a') {
      colorBlob -= 1 << 16; // red--
      break;
    case 'w':
      colorBlob += 1 << 8; // green++
      break;
    case 's':
      colorBlob -= 1 << 8; // green--
      break;
    case 'e':
      colorBlob += 1; // blue++
      break;
    case 'd':
      colorBlob -= 1; // blue--
      break;
    case 't':
      threshold++;
      break;
    case 'g':
      threshold--;
      break;
  }
  println(String.format("r: %d | g: %d | b: %d | threshold: %d", (int) red(colorBlob), (int) green(colorBlob), (int) blue(colorBlob), (int) threshold));
}
*/
