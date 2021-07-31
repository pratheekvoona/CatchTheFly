class Mover {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  int score = 0;

  Mover(float m, float x , float y) {
    mass = m;
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0,127);
    ellipse(position.x,position.y,40,10);
    ellipse(position.x + 20,position.y + 5,8,15);
    ellipse(position.x - 20,position.y + 5,8,15);
    int vel = (int)velocity.x;
    if (vel < 0) {
     vel = vel * -1; 
    }
    String s = "Velocity of the frog: " + vel + "\n          Score: " + score;
    fill(50);
    text(s, 250, 10, 200, 80); 
  }

  void checkEdges() {

    if (position.x > width) {
      position.x = width;
      
      if(velocity.x * -1.3 < -23){
        velocity.x *= -1;
      } else {
        velocity.x *= -1.1;
      }
    } else if (position.x < 0) {
      velocity.x *= -1;
      position.x = 0;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    }
    if (position.y < height - 100) {
      velocity.y *= -1;
      position.y = height - 100;
    }

  }

}
