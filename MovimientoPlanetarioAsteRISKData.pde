Planeta tierra;
Planeta marte;
Planeta jupiter;
Planeta urano;
Planeta mercurio;
int rotartiempo;

//Listado de asteroides
ArrayList<Asteroide> asteroides;
//Variable de estado
int estado;

int BIGBANG = 0;
int GALAXIA = 1;
int FIN_UNIVERSO = 2;

//Radio de la explosion
int radioBB;

PImage elSol;

Table puntajes;

//Variables para los mayores puntajes
int dy = day();
int mnth = month();
int yr = year();
int hr = hour();
int mint = minute();

int tiempoInicioJuego;
int tiempoFinal;
int tiempoActual;

void setup() {
  size(800, 800);
  background(10);
  elSol = loadImage("solsolesito.png");
  elSol.resize(100,100);
  imageMode(CENTER);
  
  //Iniciar variabl de estado
  estado = BIGBANG;
  
  //Inicio mi lista de asteroides
  asteroides = new ArrayList<Asteroide>();
  
  mercurio = new Planeta(0, 0, 50, 2, color(128, 128, 128), 15);
  tierra = new Planeta(0, 0, 100, 1.8, color(0, 0, 255), 20);
  marte = new Planeta(0, 0, 150, 0.8, color(255, 0, 0), 15);

  jupiter = new Planeta(0, 0, 200, 0.4, color(224, 167, 23), 30);
  urano = new Planeta(0, 0, 200, 0.4, color(224, 167, 23), 30);

  //Inicializa el angulo de rotacion. Inicio de los tiempos
  rotartiempo = 0;
  
  radioBB =5;
  
  //Tabla de puntajes
  puntajes = loadTable("puntaje.csv", "header,csv");
}

void draw() {
  if(estado == BIGBANG){
    //Lo que se ejecuta si estoy en BIGBANG
    background(255);
    
    fill(0);
    textSize(32);
    text("AsteRISK", width/2, height/3);
    
    textSize(18);
    text("Evita que los asteroides golpeen y destruyan la tierra...",100, height/2, width-100, height/2 );
    
    textSize(24);
    text("JUGAR", width/2-100, 2*height/3);
  }
  else if(estado == GALAXIA){
    //Lo que se ejecuta si estoy en el estado Galaxia
    background(10);
    image(elSol, width/2, height/2);
    
    //Generacion aleatoria de asyeroides
    if(random(0,1)>0.98){
      Asteroide aster = new Asteroide(random(0.1,5), 0,0, random(0.1,6),random(0.1,5));
      asteroides.add(aster);  
  }
  //Recorro lista de asteroides para actualizarlos
  for(int ast = 0; ast < asteroides.size();ast=ast+1){
    asteroides.get(ast).moverse();
    asteroides.get(ast).pintarse();
  }
  
    rotartiempo = 1;
  
    //Posicion de mouse a planetas para deternerlos
    float distMer = dist(mercurio.posicionX, mercurio.posicionY, mouseX, mouseY);
    float distT = dist(tierra.posicionX, tierra.posicionY, mouseX, mouseY);
    float distM = dist(marte.posicionX, marte.posicionY, mouseX, mouseY);
    float distJ = dist(jupiter.posicionX, jupiter.posicionY, mouseX, mouseY);
    
    mercurio.orbite(distMer);
    mercurio.gireAlrededorSol(rotartiempo);
    mercurio.pintece();
  
    tierra.orbite(distT);
    tierra.gireAlrededorSol(rotartiempo);
    tierra.pintece();
  
    marte.orbite(distM);
    marte.gireAlrededorSol(rotartiempo);
    marte.pintece();
  
    jupiter.orbite(distJ);
    jupiter.gireAlrededorSol(rotartiempo);
    jupiter.pintece();
    
    //Verificar cercania
    for(int ast = 0; ast < asteroides.size();ast=ast+1){
      Asteroide temporal = asteroides.get(ast);
      
      boolean respuestaMercurio = mercurio.meToco(temporal);
      boolean respuestaTierra = tierra.meToco(temporal);
      boolean respuestaMarte = marte.meToco(temporal);
      boolean respuestaJupiter = jupiter.meToco(temporal);
      
      if(respuestaMercurio==true || respuestaTierra == true || respuestaMarte == true || respuestaJupiter==true ){
        temporal.impactoPlaneta();
        estado = FIN_UNIVERSO;
        tiempoFinal = millis();
      }
    }
    
    //Dibuja el puntaje
    fill(255);
    textSize(12);
    tiempoActual = (millis()-tiempoInicioJuego)/100;
    text("Puntaje", width-50, 20);
    text(tiempoActual, width-50, 40);
  }
  else if(estado == FIN_UNIVERSO){
    //Calcula el puntaje    
    dy = day();
    mnth = month();
    yr = year();
    hr = hour();
    mint = minute();    
    
    //Lo que se ejecuta si estoy en FIN_UNIVERSO
    //background(255);
    fill(255);
    textSize(40);
    text("PERDISTE!!",100, height/2, width-100, height/2+50 );
    textSize(20);
    text("Tu puntaje es: "+str(tiempoActual),100, height/2 +50, width-100, height/2 +100);
    
    textSize(30);
    text("VOLVER A JUGAR",100, 2*height/3 , width-100,(2*height/3) +100 );
    
  }
  //Cuando llegue a 20 segundos de ejcucion paso al Fin del Universo
  //println(frameCount);
  //if(frameCount>600){
  //  estado = FIN_UNIVERSO;
  //}
}
void keyReleased(){
  if(key == 'a'){
    estado = BIGBANG;
  }
  else if(key == 'b'){
    estado = GALAXIA;
  }
  else if(key == 'c'){
    estado = FIN_UNIVERSO;
  }
}
void mouseReleased() {
  if(estado == BIGBANG){
    if(mouseX >= width/2-100 && mouseX <=width/2+100 && mouseY<=2*height/3+24 && mouseY>=2*height/3-24){
      estado = GALAXIA;
      tiempoInicioJuego = millis();
    }
  }
  else if(estado == GALAXIA){
    
    float distMer = dist(mercurio.posicionX, mercurio.posicionY, mouseX, mouseY);
    float distT = dist(tierra.posicionX, tierra.posicionY, mouseX, mouseY);
    float distM = dist(marte.posicionX, marte.posicionY, mouseX, mouseY);
    float distJ = dist(jupiter.posicionX, jupiter.posicionY, mouseX, mouseY);
    
    if(distMer < 20){
      mercurio.crearLuna();
    }
    if(distT < 20){
      tierra.crearLuna();
    }
    if(distM < 20){
      marte.crearLuna();
    }
    if(distJ < 20){
      jupiter.crearLuna();
    }
  }
  else if(estado == FIN_UNIVERSO){
    if(mouseX >=100 && mouseX <=width/2+100 && mouseY >=2*height/3  && mouseY<=2*height/3+24){
      //Agrega el putnaje a la lista
      TableRow newRow = puntajes.addRow();
      String fecha_puntaje = str(dy)+"-"+str(mnth)+" "+str(hr)+":"+str(mint);
      newRow.setString("fecha", fecha_puntaje);
      newRow.setInt("puntaje", tiempoActual);
      saveTable(puntajes, "data/puntaje.csv");
      
      tiempoInicioJuego = millis();
         
      //Iniciar variabl de estado
      estado = BIGBANG;
      
      //Inicio mi lista de asteroides
      asteroides = new ArrayList<Asteroide>();
      
      mercurio = new Planeta(0, 0, 50, 2, color(128, 128, 128), 15);
      tierra = new Planeta(0, 0, 100, 1.8, color(0, 0, 255), 20);
      marte = new Planeta(0, 0, 150, 0.8, color(255, 0, 0), 15);
    
      jupiter = new Planeta(0, 0, 200, 0.4, color(224, 167, 23), 30);
      urano = new Planeta(0, 0, 200, 0.4, color(224, 167, 23), 30);
    
      //Inicializa el angulo de rotacion. Inicio de los tiempos
      rotartiempo = 0;
      
      radioBB =5;
      
      //Tabla de puntajes
      puntajes = loadTable("puntaje.csv", "header,csv");
    }
  }
}
