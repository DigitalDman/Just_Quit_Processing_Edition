class Player {
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
  } // Close move func




  // open newAnimation
  void newAnimation(PImage sprite_sheet, PVector sprite_size, PVector start_cell, PVector col_row, int fps, PVector target_pos, int frames) {
    /*
    Creates a copy of sprite sheet & snips out part of it
     The 1st 2 peramiters are the top-left corner of what I cut out of the sprite sheet
     The 2nd 2 peramiters are how big the rectangle I cut is
     The 3rd set of peramiters is where I paste the cut image on my screen
     The final set of peramiters are how big I want the paste to be
     */
    
    int collum = int(col_row.x) - 1;
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
      int(target_pos.x), int(target_pos.y),
      int(sprite_size.x), int(sprite_size.y) );
    
  } // close Split Sprites func
} // close player class
