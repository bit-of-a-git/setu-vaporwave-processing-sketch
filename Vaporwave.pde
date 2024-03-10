/* Stores the number of rows and columns as variables to use when determining
 the width and height of cells */
int rows = 16;
int columns = 9;

String Name = "David O' Connor";
String Number = "08566496";

// Sets the text colour to white and uses a large font.
int textColour = 255;
int textSize = 50;

// Five colours to be used in the sketch
color backgroundColour = #1438A6; // blue

color pink = #F26BAA;
color green = #74BF04;
color yellow = #F2BC1B;
color red = #F22E2E;


void setup() {
  size(1280, 720);
  background(backgroundColour);

  // Sets the window in the top left as specified
  surface.setLocation(0, 0);

  textSize(textSize);
  drawGrid();
}

/* writeName() and writeNumber() are called the draw function so that they are
 always displayed on top of other shapes */
void draw() {
  writeName();
  writeNumber();
}

/* Sets the Name to upper case, loops through it
 character by character and prints one per row. */
void writeName() {
  fill(textColour);
  int i = 0;
  Name = Name.toUpperCase();
  while (i < Name.length()) {
    text(Name.charAt(i), i * (width / rows), textSize);
    i++;
  }
}

/* Loops through the number digit by digit and prints one per row. */
void writeNumber() {
  fill(textColour);
  int i = 0;
  do {
    text(Number.charAt(i), i * (width / rows), height);
    i ++;
  } while (i < Number.length());
}

/* Iterates through the grid, each time using random() to generate a random
 number. If it is 0, then pickRandomShape() is called, passing in i and j. It
 uses a while loop so the shapes may overlay at points */
void drawGrid() {
  for (int i = 0; i <= columns; i++) {
    for (int j = 0; j <= rows; j++) {

      while (int(random(3)) == 0) {
        pickRandomShape(i, j);
      }
    }
  }
}

/* This function is used to pick one of the four non-background colours when
 colouring shapes */
void pickRandomColour() {
  int r = int(random(0, 4));
  if (r == 0) {
    fill(pink);
  } else if (r == 1) {
    fill(green);
  } else if (r == 2) {
    fill(yellow);
  } else if (r == 3) {
    fill(red);
  }
}

// This function selects from one of the shapes
void pickRandomShape(int i, int j) {
  /* Gets the proportional width and height of each cell to pass in and use
   when creating shapes */
  float w = (width / rows);
  float h = (height / columns);

  /* Generates a random number and checks if it's 0. If so, it creates a sun
   at i, j. If not, it creates a mountain shape */
  if (int(random(0, 2)) == 0) {
    drawSun(i, j, w, h);
  } else {
    drawMountain(i, j, w, h);
  }
}

/* This function draws small suns using the i and j for x and y coordinates
 along with w and h for the width and height of each cell. */
void drawSun(int i, int j, float w, float h) {

  /* Creates initial circle using a random fill colour */
  strokeWeight(0);
  pickRandomColour();
  ellipse((j + 0.5) * w, (i + 0.5) * h, w, h);

  /* The below code draws line from the centre of the circle downward, creating
   the style of sun found in vaporwave images */
  stroke(backgroundColour);
  int numberOfLines = 5;
  float offset = h / (2 * numberOfLines);

  for (int k = 0; k < numberOfLines; k++) {
    strokeWeight(k + 2);
    line(j * w, (i + 0.5) * h + (k * offset), (j + 1) * w, (i + 0.5) * h + (k * offset));
  }
}

/* When sun() is called with no variables, it creates
 a larger sun centred at mouseX and mouseY. */
void drawSun() {
  strokeWeight(0);
  stroke(backgroundColour);
  pickRandomColour();
  ellipse(mouseX, mouseY, width / 4, width / 4);

  int numberOfLines = 10;
  float offset = (width / 8) / numberOfLines;
  for (int i = 0; i < numberOfLines; i++) {
    strokeWeight(i + 3);
    line(mouseX - (width / 4), mouseY + (i * offset), mouseX + (width / 4), mouseY + (i * offset));
  }
}

/* This function draws mountain symbols using the i and j for x and y
 coordinates along with w and h for the width and height of each cell. */
void drawMountain(int i, int j, float w, float h) {
  pickRandomColour();
  noStroke();
  /* Alternates between smaller and larger triangles, filling each alternate
   one with the background colour to create a segmented triangle */
  for (int k = 0; k < 6; k++) {
    triangle(j * w + (k * 5), (i + 1) * h, (j + 1) * w - (k * 5), (i + 1) * h, j * (w) + (w / 2), i * h + (k * 10));
    if (k % 2 == 0) {
      fill(backgroundColour);
    } else {
      pickRandomColour();
    }
  }
}

/* When mountain() is called with no variables, it creates a series of mountains 250
 pixels below where mouseX is located.*/
void drawMountain() {
  pickRandomColour();
  noStroke();
  int k = 0;
  do {
    triangle(mouseX - 300 - (k * 100), mouseY + 250, mouseX - 100 - (k * 100), mouseY + 250, mouseX - 200 - (k * 100), mouseY + 150);
    pickRandomColour();
    triangle(mouseX + 300 + (k * 100), mouseY + 250, mouseX + 100 + (k * 100), mouseY + 250, mouseX + 200 + (k * 100), mouseY + 150);
    pickRandomColour();
    k++;
  } while (k < rows);
}

/* When called, draws a grid of lines disappearing into the distance */
void drawPinkGrid() {
  strokeWeight(2);
  stroke(pink);
  int w = width / 4;
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 5; j++) {
      line(j * w, height, mouseX, mouseY + 250);
      line(0, mouseY + 250 + (i * i), width, mouseY + 250 + (i * i));
    }
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    save("Vaporwave.png");
  }
  /* Creates a picture centered on the mouseX and mouseY when called */
  else if (mouseButton == LEFT) {
    background(backgroundColour);
    drawSun();
    drawPinkGrid();
    drawMountain();
  }
}

/* Re-generates the background each time it is called */
void mouseWheel() {
  background(backgroundColour);
  drawGrid();
}
