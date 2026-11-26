class Boss{
  
  // Position & movement variables
  PVector position;
  PVector velocity = new PVector(2, 5);
  int direction = 1;
  
  // Health bar variables
  int health = 10;
  PVector bar_pos = new PVector(320, 425);
  PImage health_back; // Backsprite for the healthbar
  PImage health_fill;
  PImage health_outline;
  PVector bar_size = new PVector(170, 117); // these are the dimentions I drew it at
  
  
  //// ATTACK VARIABLES \\\\
  int current_attack = 1; // Track what our current attack is
  
  // Follow attack \\
  // These are both floats cause my method of doing timers uses frameRate, which is a float
  PVector player_position = new PVector(0, 0); // For this attack we want to track the player position
  float follow_timer = 0;
  float total_follow_time;
  
  Boss(PVector pos){
    position = pos;
    
    
    // Setting the bossbar sprites \\
    health_outline = loadImage("Boss_Bar_Frame.png");
    health_fill = loadImage("Boss_Bar_1.png");
    health_back = loadImage("Boss_Bar_Back.png");
    
    // Initializeing the boss attacks
    total_follow_time = 20 * frameRate;
    follow_timer = 0;
    current_attack = 1;
  } // Close constructor
  
  
  void display(){
    updateBar(); // Call the update bossBar function
    
  } // Close display func
  
  void updateBar(){
    image(health_back, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y); // Fill in the back of the healthbar 
    image(health_fill, bar_pos.x, bar_pos.y, bar_size.x * (health / 10.0) , bar_size.y); // The actual fill of the bossbar
    image(health_outline, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y); // The outline off the bossbar
  } // close updateBar func
  
  
  //// MOVE FUNCTION
  void move(PVector target_position){
    // So! We want to take a target position because we can use this to move to set locations for every other attack    
    
    // Find out what direction we want to go in
    if (target_position.x < position.x){
      // If we're facing left flip the sprites!
       pushMatrix();
       scale(-1, 1);
       popMatrix();
       
       // We also want to update the limits
       position.x = constrain(position.x, -width, 0 - 15);
    } else {
      // Reset the scale if you're going right
      pushMatrix();
      scale(1, 1);
      popMatrix();
      
      // Set the contraints while moving right
      position.x = constrain(position.x, 0, width - 15 );
    } // Close left-right check
    
    // Move the boss
    position.x += velocity.x;
    
  } // close move func
  
  
  
} // close player class
