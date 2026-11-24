class Boss{
  
  // Position & movement variables
  PVector position;
  PVector velocity = new PVector(5, 5);
  int direction = 1;
  
  // Health bar variables
  int health = 10;
  PVector bar_pos = new PVector(320, 400);
  PImage health_fill;
  PImage health_outline;
  PVector bar_size = new PVector(170, 117); // these are the dimentions I drew it at

  
  Boss(PVector pos){
    position = pos;
    
    health_outline = loadImage("Boss_Bar_Frame.png");
    health_fill = loadImage("Boss_Bar_1.png");
  } // Close constructor
  
  
  void display(){
    updateBar();
    
    health = 10 - (frameCount % 11);
  } // Close display func
  
  void updateBar(){
    image(health_fill, bar_pos.x, bar_pos.y, bar_size.x * (health / 10.0) , bar_size.y);
    image(health_outline, bar_pos.x, bar_pos.y, bar_size.x, bar_size.y);
  } // close updateBar func
  
  
} // close player class
