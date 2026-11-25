class Player {
  // Position & movement variables
  PVector position;
  PVector velocity = new PVector(2, 5);
  boolean left = false;
  boolean right = false;
  boolean jump_slam = false;
  boolean slam = false;
  int ground_limit = 325; // Ground is drawn at 315
  float grav_acceleration = 0.1; // This is our gravitational acceleration to start pulling our player down to the ground
  int jump_velocity = -4;

  // Cooldown & I frames \\
  float i_frames_left = 0;
  float total_i_frames;

  float cooldown = 0;
  float cooldown_length;

  // Clock variables
  float arc_start = -90;
  float arc_end = 270;
  PVector clock_position = new PVector(50, 70);
  float clock_radius = 25;

  // Spritesheet variables
  PImage player_spritesheet;
  PVector spritesheet_row_col = new PVector(0, 0); // Saving the row & collum of the sprite sheet in a PVector

  Player(PVector pos) {
    position = pos; // set player position

    // initialize variables
    total_i_frames = 0.3 * frameRate; // So we have 0.3 seconds of I frames
    cooldown_length = 5 * frameRate;
    cooldown = cooldown_length;

    player_spritesheet = loadImage("Player_Animations.png");
  } // Close constructor


  void display() {
    move();
    
    // Display the timer \\
    fill(0);
    circle(clock_position.x, clock_position.y, clock_radius + 2); // Circle & rect to actually look like a clock
    rectMode(CENTER);
    rect(clock_position.x, clock_position.y - (clock_radius / 2), 10, 10); // Draw the rect

    fill(255);
    cooldown -= 1; // Increase time by 1 per frame
    arc_start = map(cooldown, cooldown_length, 0, -90, 270 ); // Mapping its angle between -90 & 270 to hope it will 'fill'
    arc(clock_position.x, clock_position.y, clock_radius, clock_radius, radians(arc_start), radians(arc_end) ); // Draw the circle arc
  } // close display func


  void move() {
    // Used the processing documentation on scale() and pushMatrix() to understand these
    /// Left & right movement
    if (right){
      position.x += velocity.x; // Aaand we move!
      
      // Resets sprite scale
      //pushMatrix();
      //scale(1, 1);
      //position.x = abs(position.x); // Makes sure that the position is reset
      newAnimation(player_spritesheet, new PVector(30,30), new PVector(0,0), 10, position, 2); // Animate out player sprite right
      //popMatrix();
      
    } else if (left){
      position.x += velocity.x; // Since we flip the scale later on we're still technacly moving 'right'
      // Flips sprite when your moving left 
      
      pushMatrix();
      scale(-1, 1);
      position.x = -abs(position.x);
      newAnimation(player_spritesheet, new PVector(30,30), new PVector(0,0), 10, position, 2); // Animate out player sprite right
      popMatrix(); // */
      
      //println(position.x);
    } else {
      //scale(1, 1);
      position.x = abs(position.x);
      newAnimation(player_spritesheet, new PVector(30,30), new PVector(0,0), 100000, position, 2); // Animate out player sprite right
      // Yea so the 100000 thing is 
    }// close animation if's */
   
    //println("");
    /// Jumping & Slamming \\\
    //detect if the button was pressed or not
    if (jump_slam){
      
      // Detect if the players grounded
      if (position.y >= ground_limit){
          // Sets the player y velocity to their jump velocity, launching them into the air
          velocity.y = jump_velocity; 
          
          
      } else if (cooldown <= 0 && position.y < ground_limit){
        /* If you can slam:
           Increase your gravitational acceleration
           reset the slam cooldown
           Set the slam variable to true
        */
      
        grav_acceleration = 0.5;
        cooldown = cooldown_length;
        slam = true;
      } // Close slam attack if
      
      jump_slam = false; // Reset this variable just after hitting the button
      
    } // close if jump_slam
    
    // Reset your gravitational acceleration if your grounded
    if (position.y == ground_limit){
      grav_acceleration = 0.1;
    } // Close gravity reset
    
    // Gravity
    position.y += velocity.y; // Pull the player down (or shoot em up depending on if you jump or not)
    velocity.y += grav_acceleration; // And this is where we pull down the player
    
    
    // Limits
    position.y = constrain(position.y, 0, ground_limit);
    
    //*
    if (right){
      position.x = constrain(position.x, 0, width - 30 ); // -30 & +30 since our sprites are 30x30
    } else if (left) {
      position.x = constrain(position.x, -width, 0 - 30 ); 
    } // Close x-limit sets */
    
    //println(position.x);

  } // Close move func
  ////////////////////////////////////////////////////////////////////////
  // Literally just did this because my sleep deprived brain needed to break up the lines more visually



  // open newAnimation
  void newAnimation(PImage sprite_sheet, PVector sprite_size, PVector start_cell, int fps, PVector target_pos, int frames) {
    
    // takes the sprite_sheet, how big the sprites are, what cell we start at, the fps (potentially the right term?) 
    // and how many frames are in the animation
    println(target_pos);
    PVector center_pos = target_pos.copy();
    center_pos.x += sprite_size.x / 2;
    center_pos.y += sprite_size.y / 2;
    
    
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
     /*
    Creates a copy of sprite sheet & snips out part of it
     The 1st 2 peramiters are the top-left corner of what I cut out of the sprite sheet
     The 2nd 2 peramiters are how big the rectangle I cut is
     The 3rd set of peramiters is where I paste the cut image on my screen
     The final set of peramiters are how big I want the paste to be
     */
     rectMode(CENTER);
     fill(0);
    rect( center_pos.x, center_pos.y, 2, 2);
    
  } // close Split Sprites func
} // close player class
