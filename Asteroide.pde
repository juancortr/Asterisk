class Asteroide{
  float pendiente;
  int posX;
  int posY;
  int dirX;
  int dirY;
  float velocidadX;
  float velocidadY;
  
  boolean impacto;
  
  int tamAsteroide = 30;
  PImage asteroide;
  
  Asteroide(float pPendiente, int piniX, int piniY, float pVelocidadX, float pVelocidadY){
    //Cargo la imagen (la misma para todos los asteroides)
    asteroide = loadImage("asteroide.png");
    
    asteroide.resize(tamAsteroide,tamAsteroide);
    
    pendiente = pPendiente;
    posX = piniX;
    posY = piniY;
    
    velocidadX = pVelocidadX;
    velocidadY = pVelocidadY;
    
    impacto= false;
    
    //Hacia qué lado se mueve mi asteroide
    if (posX<width/2){
      dirX = 1;
    }
    else{
      dirX = -1;
    }
    
    if (posY<height/2){
      dirY = 1;
    }
    else{
      dirY = -1;
    }
  }
  
  void moverse(){
    posX = int(posX+(velocidadX*dirX));
    posY = int(posY+(velocidadY*dirY));
  }
  
  void pintarse(){
    if(impacto == false){
      image(asteroide,posX, posY);
    }    
  }
  
  void impactoPlaneta(){
    impacto = true;
  }
}
