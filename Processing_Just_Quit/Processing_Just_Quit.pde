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
  rect(0, 350, width, height);
  
  player.display();
  boss.display();
} // Close draw


void keyPressed(){
  
  // Using a fall through switch to detect button inputs (I just like these more than else-ifs & OR's)
  switch (key){
    case 'D':
    case 'd':
      player.right = true;
      player.left = false;
      break;
    
    case 'A':
    case 'a':
      player.right = false;
      player.left = true;
      break;
    
    case ' ':
    case '1':
        player.jump_slam = true;
        break;
  } // Close key switch
  
} // Close keyPressed

void keyReleased(){
  // Only reset the left & right movement if its not a jump button you let go of
  if (key != ' ' && key != '1'){
    player.left = false;
    player.right = false;
  } // close reset if
} // close key released
