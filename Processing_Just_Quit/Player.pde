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
  
  // Clock variables
  float arc_start = -90;
  float arc_end = 270;
  PVector clock_position = new PVector(50, 70);
  float clock_radius = 25;
  
  
  Player(PVector pos){
    total_i_frames = 0.3 * frameRate; // So we have 0.3 seconds of I frames
    cooldown_length = 5 * frameRate;
    cooldown = cooldown_length;
    
    position = pos;
    
  } // Close constructor
  
  
  void display(){
    
    // Display the timer \\
    fill(0);
    circle(clock_position.x, clock_position.y, clock_radius + 2); // Circle & rect to actually look like a clock
    rectMode(CENTER);
    rect(clock_position.x,   clock_position.y - (clock_radius / 2), 10, 10); // Draw the rect
    
    fill(255);
    cooldown -= 1; // Increase time by 1 per frame
    arc_start = map(cooldown, cooldown_length, 0 , -90, 270 ); // Mapping its angle between -90 & 270 to hope it will 'fill'
    arc(clock_position.x, clock_position.y   , clock_radius, clock_radius, radians(arc_start), radians(arc_end) ); // Draw the circle arc
    
  } // close display func
  
} // close player class
