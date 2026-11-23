class Player{
  // Position & movement variables
  PVector position;
  PVector velocity = new PVector(5, 5);
  boolean left = false;
  boolean right = false;
  boolean slam = false;
  
  // Cooldown & I frames \\
  float i_frames_left = 0;
  float total_i_frames;
  
  float cooldown = 0;
  float cooldown_length;
  
  Player(PVector pos){
    total_i_frames = 0.3 * frameRate; // So we have 0.3 seconds of I frames
    cooldown_length = 5 * frameRate;
    
    position = pos;
    
  } // Close constructor
  
  
} // close player class
