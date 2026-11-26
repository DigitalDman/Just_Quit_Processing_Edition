class Boss{
  
  // Position & movement variables
  PVector position;
  PVector velocity = new PVector(1.3, 5);
  PVector acceleration = new PVector(0.1, 0.1);
  int direction = 1;
  
  // Health bar variables
  int health = 10;
  PVector bar_pos = new PVector(320, 425);
  PImage health_back; // Backsprite for the healthbar
  PImage health_fill;
  PImage health_outline;
  PVector bar_size = new PVector(170, 117); // these are the dimentions I drew it at
    
  // Spritesheet variables
  PImage boss_spritesheet;
  PVector spritesheet_row_col = new PVector(0, 0); // Saving the row & collum of the sprite sheet in a PVector
  
  //// ATTACK VARIABLES \\\\
  int current_attack = 1; // Track what our current attack is
  
  // Follow attack \\
  // These are both floats cause my method of doing timers uses frameRate, which is a float
  PVector player_position = new PVector(0, 0); // For this attack we want to track the player position
  float follow_timer = 0;
  float total_follow_time;
  
  Boss(PVector pos){
    position = pos;
    
    // Setting the sprite_sheet
    boss_spritesheet = loadImage("boss_spritesheet.png");
    
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
    
    move(player_position, velocity.copy());
  } // Close display func
  
  void updateBar(){
    image(health_back, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y); // Fill in the back of the healthbar 
    image(health_fill, bar_pos.x, bar_pos.y, bar_size.x * (health / 10.0) , bar_size.y); // The actual fill of the bossbar
    image(health_outline, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y); // The outline off the bossbar
  } // close updateBar func
  
  
  //// MOVE FUNCTION
  void move(PVector target_position, PVector vel){
    // So! We want to take a target position because we can use this to move to set locations for every other attack    
    //println(position);
    
    // Find out what direction we want to go in
    // Using abs to make sure its the normal positions & not the flipped ones
    if (abs(target_position.x) < abs(position.x) ){
      // For when we want to move left!
      pushMatrix();
      scale(-1, 1);
      position.x = -abs(position.x);
      newAnimation(boss_spritesheet, new PVector(30, 30), new PVector(0,0), 10, position, 2);
      popMatrix();
      
      // Constrain boss position when flips
      position.x = constrain(position.x, -width, 0 - 15 );
    } else {
      pushMatrix();
      scale(1, 1);
      position.x = abs(position.x);
      newAnimation(boss_spritesheet, new PVector(30, 30), new PVector(0,0), 10, position, 2);
      popMatrix();
      
      // Constrain the bosses position
      position.x = constrain(position.x, 0, width - 15 );
    } // Close left-right if
    
    // Move the boss
    position.x += vel.x;
    position.y += vel.y;
    vel.y += acceleration.y;
    
    //Limit the bosses y position
    position.y = constrain(position.y, 0, 340);
    
  } // close move func 
  
    // Animate sprite sheet function
    // open newAnimation
  void newAnimation(PImage sprite_sheet, PVector sprite_size, PVector start_cell, int fps, PVector target_pos, int frames) {
    
    // takes the sprite_sheet, how big the sprites are, what cell we start at, the fps (potentially the right term?) 
    // and how many frames are in the animation
    //println(target_pos);
    PVector center_pos = target_pos.copy();
    center_pos.x -= sprite_size.x / 2;
    center_pos.y -= sprite_size.y / 2;
    
    
    int collum = int(start_cell.x); // Lable what collum we're at
    
    // Update the frame depending on the fps variable
    if (frameCount % fps == 0) {
      //println(spritesheet_row_col);
      spritesheet_row_col.x += 1;

      if (spritesheet_row_col.x == frames) {
        spritesheet_row_col.x = 0;
      } // Close frame-reset
    } // Close row incrimentation

    copy(sprite_sheet,
      int( (start_cell.x + spritesheet_row_col.x) * sprite_size.x ),
      int( (start_cell.y + collum) * sprite_size.y ),
      int(sprite_size.x), int(sprite_size.y),
      int(center_pos.x), int(center_pos.y),
      int(sprite_size.x), int(sprite_size.y) );
  } // close Split Sprites func
  
} // close player class
