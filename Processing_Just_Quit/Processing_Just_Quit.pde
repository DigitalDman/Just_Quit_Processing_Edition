// VARIABLES \\
Player player;
Boss boss;
boolean space_hit = false; // To make sure you cant hold the jump button to slam attack

void setup() {
  size(640, 512);
  imageMode(CENTER); // Set the image mode to the center as all our sprite measurements were done from the center

  boss = new Boss( new PVector(200, 200) );
  player = new Player( new PVector(width/2, height/2) );
} // Close setup


void draw() {
  background(65, 138, 186);
  // Draw ground
  fill(82, 166, 93);
  rectMode(CORNERS);
  noStroke();
  rect(0, 350, width, height);
  
  // Update our player & boss displays
  player.display();
  boss.display();
  
  // Feed the boss the player position
  boss.player_position = player.position.copy();
} // Close draw


void keyPressed() {

  // Using a fall through switch to detect button inputs (I just like these more than else-ifs & OR's)
  switch (key) {
  case 'D':
  case 'd':
    player.right = true;
    player.left = false;
    break;

  case 'A':
  case 'a':
    player.left = true;
    player.right = false;
    break;

  case ' ':
  case '1':
    if (!space_hit) {
      player.jump_slam = true;
      space_hit = true;
      break;
    } // close if !space_hit
  } // Close key switch
} // Close keyPressed

void keyReleased() {
  // Use a switch to reset the left & right movement
  switch (key){
    case 'D':
    case 'd':
      player.right = false;
      break;
  
    case 'A':
    case 'a':
      player.left = false;
      break;
  } // close switch
  
  if (space_hit){
    space_hit = false;
  } // 
} // close key released
