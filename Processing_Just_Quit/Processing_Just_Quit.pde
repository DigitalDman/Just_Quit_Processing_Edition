// VARIABLES \\
Player player;
Boss boss;

void setup(){
  size(640, 512);
  imageMode(CENTER); // Set the image mode to the center as all our sprite measurements were done from the center
  
  boss = new Boss( new PVector(200, 200) );
  player = new Player( new PVector(width/2, height/2) );
} // Close setup


void draw(){
  background(65, 138, 186);
  // Draw ground
  fill(82, 166, 93);
  rectMode(CORNERS);
  noStroke();
  rect(1, 350, width, height);
  
  player.display();
  boss.display();
} // Close draw
