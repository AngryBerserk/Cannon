class Mover {
  PVector location;
  PVector speed;
  PVector acceleration;
  float mass;
  float angle;
  float angularAcceleration;
  float angularVelocity;
  float maxspeed = 20;
  float edgeThreshold = 20;

  Mover(float x, float y, float m) {
    location = new PVector(x,y);
    speed = new PVector();
    //speed = PVector.random2D().mult(3);
    acceleration = new PVector();
    mass = m;
  }

  void applyForce(PVector force) {
    PVector f = force.copy().div(mass);
    acceleration.add(f.div(mass));
  }
  
  void applyAngular(float force){
    angularAcceleration += force;
    
  }
  
  void checkEdges(){
      float lx = location.x - edgeThreshold;
      float rx = location.x - (width - edgeThreshold);
      if (lx < edgeThreshold){
         applyForce(new PVector((lx*lx),0)); 
      }else
      if (rx > edgeThreshold){
         applyForce(new PVector((rx*rx) * (-1),0));
      }
  }
  
  void move(){
    if (location.y < mass){
      speed.y *= -1;
      location.y = mass;
    }
    speed.add(acceleration);
    location.add(speed.limit(maxspeed));
    acceleration.mult(0);
    angularVelocity += angularAcceleration;
    angularAcceleration = 0;
    angle += angularVelocity;
  }

  void draw() {
    fill(255);
    stroke(0);
    pushMatrix();
    translate(location.x, height - location.y);
    float a = speed.heading();
    rotate(a);
    rect(-(mass/2), -(mass/2), mass, mass);
    ellipse(0,0,5,5);
    popMatrix();
  }
}