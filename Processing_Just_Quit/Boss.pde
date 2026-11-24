class Boss{
  
  // Position & movement variables
  PVector position;
  PVector velocity = new PVector(5, 5);
  int direction = 1;
  
  // Health bar variables
  int health = 10;
  PVector bar_pos = new PVector(320, 400);
  PImage health_back;
  PImage health_fill;
  PImage health_outline;
  PVector bar_size = new PVector(170, 117); // these are the dimentions I drew it at

  
  Boss(PVector pos){
    position = pos;
    
    
    // Setting the bossbar sprites \\
    health_outline = loadImage("Boss_Bar_Frame.png");
    health_fill = loadImage("Boss_Bar_1.png");
    health_back = loadImage("Boss_Bar_Back.png");
  } // Close constructor
  
  
  void display(){
    updateBar(); // Call the update bossBar function
    
  } // Close display func
  
  void updateBar(){
    image(health_back, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y); // Fill in the back of the healthbar 
    image(health_fill, bar_pos.x, bar_pos.y, bar_size.x * (health / 10.0) , bar_size.y); // The actual fill of the bossbar
    image(health_outline, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y); // The outline off the bossbar
  } // close updateBar func
  
  
} // close player class
