class Mapa {
  PVector posicaoGrid = new PVector();
  int largura;
  int altura;
  float tamanhoCelula;
  Personagem pers;
  ArrayList<Inimigo> inimigos         = new ArrayList<Inimigo>();
  ArrayList<Coletavel> coletaveis     = new ArrayList<Coletavel>();
  ArrayList<GameObject> todosObjetos  = new ArrayList<GameObject>();
  ArrayList<PVector> posicoesLivres   = new ArrayList<PVector>(); 
  int fitness = 0;
  int fitnessTotal = 0;
  
  Mapa() {
    this.posicaoGrid.x = 20;
    this.posicaoGrid.y = 25;
    this.largura       = 32;
    this.altura        = 32;
    this.tamanhoCelula = 15;
    
    // config personagem no mundo
    this.pers = new Personagem();
    this.pers.posicao.x = (int)random(0, this.largura);
    this.pers.posicao.y = (int)random(0, this.altura);
    this.pers.criarMovimentos();
    
    // TODO: Manusear ausencia de posicoes livres
    // gera lista de posicoes livres
    for (int i = 0; i < this.altura; i++) {
      for (int j = 0; j < this.largura; j++) {
        this.posicoesLivres.add(new PVector());
        this.posicoesLivres.get(this.posicoesLivres.size() - 1).x = j;
        this.posicoesLivres.get(this.posicoesLivres.size() - 1).y = i;
      }
    }
    
    int posAleatoria;
    
    for (int i = 0; i < 200; i++) {
      this.inimigos.add(new Inimigo());
      posAleatoria = (int)random(0, this.posicoesLivres.size());
      this.inimigos.get(i).posicao.x = this.posicoesLivres.get(posAleatoria).x;
      this.inimigos.get(i).posicao.y = this.posicoesLivres.get(posAleatoria).y;
      this.posicoesLivres.remove(posAleatoria);
    }
    
    for (int i = 0; i < 100; i++) {
      posAleatoria = (int)random(0, this.posicoesLivres.size());
      this.coletaveis.add(new Coletavel());
      this.coletaveis.get(i).posicao.x = this.posicoesLivres.get(posAleatoria).x;
      this.coletaveis.get(i).posicao.y = this.posicoesLivres.get(posAleatoria).y;
      this.posicoesLivres.remove(posAleatoria);   
    }
    this.todosObjetos.addAll(this.inimigos);
    this.todosObjetos.addAll(this.coletaveis);
    for (int i = 0; i < this.posicoesLivres.size(); i++) {
      this.todosObjetos.add(new EmptyObject()); //<>//
      this.todosObjetos.get(this.todosObjetos.size() - 1).posicao.x = this.posicoesLivres.get(i).x;
      this.todosObjetos.get(this.todosObjetos.size() - 1).posicao.y = this.posicoesLivres.get(i).y;
    }
  }
  
  Mapa(Mapa mapaPai) {
    this.posicaoGrid.x = mapaPai.posicaoGrid.x;
    this.posicaoGrid.y = mapaPai.posicaoGrid.y;
    this.largura       = mapaPai.largura;
    this.altura        = mapaPai.altura;
    this.tamanhoCelula = mapaPai.tamanhoCelula;
    
    this.pers = new Personagem();
    this.pers.posicao.x = mapaPai.pers.posicao.x;
    this.pers.posicao.y = mapaPai.pers.posicao.y;
    this.pers.criarMovimentos();
    
    for (int i = 0; i < mapaPai.inimigos.size(); i++) {
      this.inimigos.add(new Inimigo());
      this.inimigos.get(i).posicao.x = mapaPai.inimigos.get(i).posicao.x;
      this.inimigos.get(i).posicao.y = mapaPai.inimigos.get(i).posicao.y;
    }
    
    for (int i = 0; i < mapaPai.coletaveis.size(); i++) {
      this.coletaveis.add(new Coletavel());
      this.coletaveis.get(i).posicao.x = mapaPai.coletaveis.get(i).posicao.x;
      this.coletaveis.get(i).posicao.y = mapaPai.coletaveis.get(i).posicao.y;
    }
    
    for (int i = 0; i < mapaPai.todosObjetos.size(); i++) {
      this.todosObjetos.add(new EmptyObject());
      this.todosObjetos.get(i).posicao.x = mapaPai.todosObjetos.get(i).posicao.x;
      this.todosObjetos.get(i).posicao.y = mapaPai.todosObjetos.get(i).posicao.y;
      this.todosObjetos.get(i).etiqueta = mapaPai.todosObjetos.get(i).etiqueta;
    }
    
  }
  
  void desenhar() {
    rect(this.posicaoGrid.x, this.posicaoGrid.y, this.largura * this.tamanhoCelula, this.altura * this.tamanhoCelula);
    
    // desenhar grid
    if (desenharGrid) {
      noFill();
      stroke(150,150,150);
      for (int i = 0; i < this.largura; i++) {
        for (int j = 0; j < this.altura; j++) {        
          desenharCelula(i, j);  
        }
      }
    } else {
      stroke(150,150,150);
    }
    
    // desenhar inimigos
    fill(this.inimigos.get(0).cor);
    for (Inimigo inimigo : this.inimigos) {
      desenharCelula(inimigo.posicao.x, inimigo.posicao.y);
    }
    
    // desenhar coletaveis
    fill(this.coletaveis.get(0).cor);
    for (Coletavel coletavel : this.coletaveis) {
      desenharCelula(coletavel.posicao.x, coletavel.posicao.y);
    }
    
    // desenhar personagem
    fill(pers.cor);
    desenharCelula(this.pers.posicao.x, this.pers.posicao.y); // ERRO
  }
  
  void desenharCelula(float x, float y) {
    rect(this.posicaoGrid.x + (x * this.tamanhoCelula),
         this.posicaoGrid.y + (y * this.tamanhoCelula),
         this.tamanhoCelula, this.tamanhoCelula);
  }
  
  void atualizar() {
    if (this.pers.emMovimento) {
      if (this.pers.indiceMovimento < this.pers.qtdeMovimentos) {
        this.pers.movimentar();
        this.pers.indiceMovimento++;
        verificarPosicaoPersonagem();
        calcularFitness(this);
      } else {
        delay(50);
        if (autoSimulate) {
          novaGeracao = true;
        }
        this.pers.emMovimento = false;
      }
    }
  }
  
  void resetarValores() {
    this.pers.posicao.x = posicaoInicialPersonagem.x;
    this.pers.posicao.y = posicaoInicialPersonagem.y;
    this.pers.indiceMovimento = 0;
    this.fitness = 0;
    this.fitnessTotal = 0;
  }
  
  // TODO: analisar se é melhor separar essa função dentro da classe Personagem
  void verificarPosicaoPersonagem() {
    float persX = this.pers.posicao.x;
    float persY = this.pers.posicao.y;
    
    if (persX > this.largura - 1) {
      this.pers.posicao.x = this.largura - 1;
    }
    if (persX < 0) {
      this.pers.posicao.x = 0;
    }
    if (persY > this.altura - 1) {
      this.pers.posicao.y = this.altura - 1;
    }
    if (persY < 0) {
      this.pers.posicao.y = 0;
    }
  }
}
