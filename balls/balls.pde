class Ball {
  PVector position;
  float heading;
  boolean odd;

  Ball(float x, float y, float heading, boolean odd) {
    this.position = new PVector(x, y);
    this.heading = heading;
    this.odd = odd;
  }

  void draw() {
    this.updatePosition();    
    pushMatrix();
    translate(this.position.x, this.position.y, this.position.z);
    rotate(noise(this.position.x, this.position.y));
    noStroke();
    sphere(20);
    popMatrix();
  }

  void updatePosition() {
    PVector velocity = new PVector(1, 0);
    velocity.rotate(this.heading);
    this.position.add(velocity);
    float n = norm(frameCount % 240, 0, 240);
    if (odd) {
      this.position.z = 50 * sin(n * TWO_PI);
    } else {
      this.position.z = 50 * sin(-n * TWO_PI);
    }
  }
}

ArrayList<Ball> balls;

void setup() {
  size(1025, 768, P3D);
  balls = new ArrayList<Ball>();
  int n = 10;
  for (int i = 0; i < n; i++) {
    float y = map(i, 0, n, 0, height);
    balls.add(new Ball(0, y, 0, i % 2 == 0));
  }
//  for (int i = 0; i < n; i++) {
//    float x = map(i, 0, n, 0, width);
//    balls.add(new Ball(x, 0, PI * 0.5, i % 2 == 0));
//  }
}

void draw() {
//  background(255);
  lights();
  for (Ball ball : balls) {
    ball.draw();
  }
}
