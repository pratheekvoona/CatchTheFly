Mover[] movers = new Mover[1];
// Variables for petal arguments
float a;
float n;
float x = 180;
float y = 180;
 
// Variables for polar coordinates
float angle;
float angleStep;
 
// Variables for fly trail
PVector[] trail;
int nTrail;
void mousePressed(){
  if ((movers[0].position.x - trail[nTrail-1].x < 100 && movers[0].position.x - trail[nTrail-1].x > -100)) {
    float r = rose(a, n, angle);
    PVector loc = new PVector(x + r * cos(angle), y + r * sin(angle));
    x = random(100,600);
    y = random(150,300);
    line(movers[0].position.x,movers[0].position.y,trail[nTrail-1].x,trail[nTrail-1].y);
    movers[0].score += 1;
    newFlyLocation(loc);
     
    // Draw the trail and the fly
    drawFlyAndTrail();
  } else {
    movers[0].score -= 1;
    if (movers[0].score < 0) {
      movers[0].score = 0;
    }
  }
  
  
}
void setup() {
  //size(640,360);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(1,0,0); 
  }
  //size(640,360);
  a = 100;
  n = 3;
 
  angle = 0;
  angleStep = TWO_PI / 200.0;
 
  nTrail = 10;
  trail = new PVector[nTrail];
}
float rose(float a, float n, float angle)
{
  return a * sin(n * angle);
}
 
public void settings() {
  size(640, 360);
}

void draw() {
  background(255);
  //size(640,360);
  
  for (int i = 0; i < movers.length; i++) {

    PVector wind = new PVector(0.01,0);
    PVector gravity = new PVector(0,0.2);
    
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
  // Calculate the current location of the fly and save it
  float r = rose(a, n, angle);
  PVector loc = new PVector(x + r * cos(angle), y + r * sin(angle));
  x = x + random(-1,1);
  y = y + random(-1,1);
  newFlyLocation(loc);
 
  // Draw the trail and the fly
  drawFlyAndTrail();
 
  // Update the angle for the fly's next location
  angle += angleStep;
  if (angle >= TWO_PI)
  {
    angle = 0;
  }
  /**
* Updates the trail and saves the new location of the fly.
*/
}

void newFlyLocation(PVector loc)
{
  for (int i = nTrail - 1; i > 0; i -= 1)
  {
    trail[i] = trail[i - 1];
  }
 
  trail[0] = loc;
}
 void drawFlyAndTrail()
{
  // Control the transparency of the trail
  int alpha = 0;
 
  // Draw the trail
  for(int i = nTrail - 1; i >= 0; i -= 1)
  {
    // Set the fill and update the alpha value for the next item in the
    // trail. When i = 0 then we have reached the current location of
    // the fly and it will be drawn with full opacity (alpha = 255)
    fill(255, 0, 0, 255);
   
    alpha = 255 / nTrail;
   
    // Skip empty cells in the trail array
    if(trail[i] == null)
    {
      continue;
    }
    if (i == nTrail-1){
      ellipse(trail[i].x, trail[i].y, 10, 20);
      ellipse(trail[i].x + 10, trail[i].y - 5, 10, 5);
      ellipse(trail[i].x - 10, trail[i].y - 5, 10, 5);
    }
  }
}
