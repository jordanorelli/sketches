import gifAnimation.*;
GifMaker gifExport;

int loopFrames = 60;
PVector maskOrigin;
Float maskWidth = 250.0;
float orbitWidth = 100.0;

void setup() {
  gifExport = new GifMaker(this, "export.gif", 30);
  gifExport.setRepeat(0); // make it an "endless" animation

  maskOrigin = new PVector();
  smooth();
  size(500, 500);
  noStroke();  
  colorMode(HSB, 100, 100, 100, 100);
}

void draw() {
  background(0, 0, 100);
  float phase = norm(frameCount % loopFrames, 0, loopFrames) * TWO_PI;
  maskOrigin.x = sin(phase) * orbitWidth + width / 2.0;
  maskOrigin.y = cos(phase) * orbitWidth + height / 2.0;
  
  float r = 16.0;
  float w = 2.0 * sin(PI/3.0) * r;
  boolean flip = false;
  for (float x = 2.0 * r; x < width - r; x += w) {
    flip = !flip;
    for (float y = 3.0 * r; y < height - r; y+= (r * 2.0)) {
      if (flip) {
        drawHex(x, y - r, r);
      } else {
        drawHex(x, y, r);
      }
    } 
  }
  export();
}

void drawHex(float x, float y, float size) {
  float n = 6.0;
  float t = TWO_PI/n;
  PVector hexOrigin = new PVector(x, y);
  float d = hexOrigin.dist(maskOrigin);
  float saturation = norm(d, maskWidth / 2.0, 0) * 200.0 * noise(x, y, 1);
  float hue = map(noise(x, y), 0.0, 1.0, 55, 60);
  
  fill(hue, saturation, 100);
  pushMatrix();  
  translate(-size * cos(t), -size * sin(t));
  translate(x, y);
  rotate(norm(frameCount % loopFrames, 0, loopFrames) * TWO_PI);

  beginShape();
  for (int i = 0; i < n; i++) {
    x = size * cos(float(i) * t);
    y = size * sin(float(i) * t);
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
}

void export() {
  if(frameCount < loopFrames) {
    gifExport.setDelay(100);
    gifExport.addFrame();
  } else {
    gifExport.finish();
    println("gif saved");
    exit();
  }
}