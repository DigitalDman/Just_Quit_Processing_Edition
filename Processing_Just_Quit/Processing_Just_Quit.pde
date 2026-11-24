// VARIABLES \\
Player player = new Player( new PVector(200, 200) );
Boss boss;

void setup(){
  size(640, 512);
  imageMode(CENTER); // Set the image mode to the center as all our sprite measurements were done from the center
  
  boss = new Boss( new PVector(200, 200) );
  frameRate(1);
} // Close setup


void draw(){
  background(65, 138, 186);
  
  player.display();
  boss.display();
   
} // Close draw
