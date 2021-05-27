class Luna{
  float posicionX;
  float posicionY;
  int distanciaAlPlaneta;
  float anguloGiro;
  float velocidadGiro;
    
  color colorPlaneta;
  int radioPlaneta;
  
  boolean seMueve;
  
  Luna(float posicionXInicial, float posicionYInicial ){
    posicionX = posicionXInicial;
    posicionY = posicionYInicial;
    distanciaAlPlaneta = 20;
    
    anguloGiro = random(0,360);
    velocidadGiro = random(5, 7);
    
    colorPlaneta = color(200,200,200);
    radioPlaneta = 10;
    
    seMueve = true;
  }
  void gireAlrededorPlaneta(float rotarTiempo){
    if(seMueve == true){
      anguloGiro = anguloGiro+rotarTiempo;
      posicionX = distanciaAlPlaneta*sin(radians(velocidadGiro*anguloGiro));
      posicionY = distanciaAlPlaneta*cos(radians(velocidadGiro*anguloGiro));
      
    }
  }
  
  void pintece(float origenXPlaneta,float origenYPlaneta){
    pushMatrix();
    translate(origenXPlaneta, origenYPlaneta);
    fill(colorPlaneta);
    ellipse(posicionX,posicionY,radioPlaneta,radioPlaneta);
    popMatrix();
  }
}
