PVector p1;
PVector p2;
PVector origin;

void setup() {
  size(500, 500);
  background(255);
  origin = new PVector(width * 0.5, height * 0.5);
  p1 = new PVector(0, height * -0.25);
  p2 = new PVector(width * 0.25, 0);
}

void draw() {
  background(255);

  translate(origin.x, origin.y);

  strokeWeight(4);
  stroke(255, 0, 0);
  line(0, 0, p1.x, p1.y);
  
  stroke(0, 255, 0);
  line(0, 0, p2.x, p2.y);

  float p3 = PVector.dot(p1, p2);
  fill(0);
  textAlign(CENTER);
  text(p3, 0, height * 0.25);
}

void mouseClicked() {
  p2.x = mouseX - origin.x;
  p2.y = mouseY - origin.y;
}

void mouseDragged() {
  p2.x = mouseX - origin.x;
  p2.y = mouseY - origin.y;  
}