float rectSize = 30;
int numRects = 40;
float outerRadius = 120;
int aframes = 140;
boolean SAVE_FRAMES = true;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);
  drawRects(numRects);  
  export();
}

void export() {
  if (!SAVE_FRAMES) {
    return;
  }
  if (frameCount > aframes) {
    return;
  }
  String fname = nf((frameCount), 3) + ".png";
  println(fname);
  save(fname);
}

void drawRects(int numRects) {
  for (int i = 0; i < numRects; i++) {
    drawRect(i, numRects);
  }
}

void drawRect(int i, int numRects) {
  float n = norm(i, 0, numRects);
  float offset = 80.0 * sin((5 * TWO_PI * n) + (TWO_PI * norm(frameCount%aframes, 0, aframes)));
  pushMatrix();
  translate(width*0.5, height*0.5);
  rotate(n*TWO_PI);
  translate(outerRadius+offset, 0);
  drawRect();
  popMatrix();
  stroke(255, 0, 0);
}

void drawRect() {
  stroke(0);
  strokeWeight(2);
  fill(255);
  rectMode(CENTER);
  rect(0, 0, rectSize, rectSize, 6);
}
