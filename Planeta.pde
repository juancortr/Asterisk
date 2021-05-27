class Planeta{
  float posicionX;
  float posicionY;
  int distanciaAlSol;
  float anguloGiro;
  float velocidadGiro;
  
  color colorPlaneta;
  int radioPlaneta;
  
  boolean impactado = false;
  boolean seMueve;
  
  Luna[] lunas;
  int maxLunas;
  
  Planeta(float posicionXInicial, float posicionYInicial, int distanciaAlSolInic, float velocidadGiroInic, color colorInicial, int radioPInic ){
    posicionX = posicionXInicial;
    posicionY = posicionYInicial;
    distanciaAlSol = distanciaAlSolInic;
    
    anguloGiro = 0;
    velocidadGiro = velocidadGiroInic;
    
    colorPlaneta = colorInicial;
    radioPlaneta = radioPInic;
    
    seMueve = true;
    
    maxLunas = 5;
    lunas = new Luna[maxLunas];
  }
  
  void gireAlrededorSol(float rotarTiempo){
    if(seMueve == true && impactado==false){
      //Actualizar posicion del planeta
      anguloGiro = anguloGiro+rotarTiempo;
      posicionX = distanciaAlSol*sin(radians(velocidadGiro*anguloGiro))+(width/2);
      posicionY = distanciaAlSol*cos(radians(velocidadGiro*anguloGiro))+(height/2);
      
      //Actualizar posicion de las lunas
      boolean termino = false;
      for(int i = 0 ; i < maxLunas && !termino; i++){
        if(lunas[i]!=null){
          lunas[i].gireAlrededorPlaneta(rotarTiempo);
        }
        else{
          termino=true;
        }
      }
    }
  }
  
  void pintece(){
    if(impactado == false){
      fill(colorPlaneta);
      ellipse(posicionX,posicionY,radioPlaneta, radioPlaneta);
      
      //Pinte las lunas
      boolean termino = false;
      for(int i = 0 ; i < maxLunas && !termino; i++){
        if(lunas[i]!=null){
          lunas[i].pintece(posicionX, posicionY);
        }
        else{
          termino=true;
        }
      }
    }
    else{
      fill(50);
      ellipse(posicionX,posicionY,radioPlaneta, radioPlaneta);      
    }
  }
  
  //Metodo para resolver si un asteroide impacto la superficie del planeta
  boolean meToco(Asteroide ast){
    boolean meToco = false;
    float distancia = dist(ast.posX, ast.posY, posicionX, posicionY);
    if(distancia < (radioPlaneta+ast.tamAsteroide)/2){
      meToco = true;
      impactado = true;
    }
    return meToco;
  }
  
  void orbite(float distanciaCursor){
    if(distanciaCursor < 20){
      seMueve = false;
    }
    else{
      seMueve = true;
    }
  }
  
  void crearLuna(){
    boolean termino = false;
    for(int i = 0 ; i < maxLunas && !termino; i++){
      if(lunas[i]==null){
        lunas[i]=new Luna(0,0);
        termino = true;
      }
    }
  }
}
