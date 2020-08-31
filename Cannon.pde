ArrayList<Mover> balls = new ArrayList<Mover>();
PVector gravity = new PVector(0, -0.1);

void setup(){
  size(800,600);  
}

void mousePressed(){
  Mover m = new Mover(0,12,16);
  PVector force = new PVector(random(1000,2000), random(500,800));
  m.applyForce(force);
  float angularForce = random(0,1);
  m.applyAngular(angularForce / 10);
  balls.add(m);
}


void draw(){
  background(255,255,255);
  //cannon
  
  //balls
  for (Mover m : balls){
    PVector g = gravity.copy();
    g.y *= m.mass;
    m.applyForce(g);
    m.checkEdges();
    m.move();
    m.draw();
  }
}