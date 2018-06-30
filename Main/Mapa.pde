class Mapa {
  PVector posicaoGrid = new PVector();
  int largura;
  int altura;
  float tamanhoCelula;
  Personagem pers;
  ArrayList<Inimigo> inimigos = new ArrayList<Inimigo>();
  ArrayList<Coletavel> coletaveis = new ArrayList<Coletavel>();
  ArrayList<PVector> posicoesLivres = new ArrayList<PVector>(); 
  int fitness = 0;
  
  Mapa() {
    this.posicaoGrid.x = 0;
    this.posicaoGrid.y = 25;
    this.largura = 32;
    this.altura = 32;
    this.tamanhoCelula = 15;
    
    // config personagem no mundo
    this.pers = new Personagem();
    this.pers.posicao.x = (int)random(0, this.largura);
    this.pers.posicao.y = (int)random(0, this.altura);
    this.pers.criarMovimentos();
    
    // TODO: Manusear ausencia de posicoes livres
    // gera lista posicoes livres
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
    
    for (int i = 0; i < 30; i++) {
      posAleatoria = (int)random(0, this.posicoesLivres.size());
      this.coletaveis.add(new Coletavel());
      this.coletaveis.get(i).posicao.x = this.posicoesLivres.get(posAleatoria).x;
      this.coletaveis.get(i).posicao.y = this.posicoesLivres.get(posAleatoria).y;
      this.posicoesLivres.remove(posAleatoria);   
    }
  }
  
  Mapa(Personagem pers, ArrayList<Inimigo> inimigos, ArrayList<Coletavel> coletaveis) {
    this.posicaoGrid.x = 0;
    this.posicaoGrid.y = 0;
    this.largura = 32;
    this.altura = 32;
    this.tamanhoCelula = 15;
    
    this.pers = new Personagem();
    this.pers.posicao.x = pers.posicao.x;
    this.pers.posicao.y = pers.posicao.y;
    this.pers.criarMovimentos();
    
    for (int i = 0; i < inimigos.size(); i++) {
      this.inimigos.add(new Inimigo());
      this.inimigos.get(i).posicao.x = inimigos.get(i).posicao.x;
      this.inimigos.get(i).posicao.y = inimigos.get(i).posicao.y;
    }
    
    for (int i = 0; i < coletaveis.size(); i++) {
      this.coletaveis.add(new Coletavel());
      this.coletaveis.get(i).posicao.x = coletaveis.get(i).posicao.x;
      this.coletaveis.get(i).posicao.y = coletaveis.get(i).posicao.y;
    }
  }
  
  void desenhar() {
    // desenhar grid
    noFill();
    stroke(150,150,150);
    for (int i = 0; i < this.largura; i++) {
      for (int j = 0; j < this.altura; j++) {        
        desenharCelula(i, j);  
      }
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
      if (this.pers.indiceMovimento < this.pers.movimentos.length) {
        delay(10);
        this.pers.movimentar();
        this.pers.indiceMovimento += 1;
        verificarPosicaoPersonagem();
        calcularFitness(this);
      } else {
        this.pers.emMovimento = false;
      }
    }
  }
  
  void resetarValores() {
    this.pers.posicao.x = posicaoInicialPersonagem.x;
    this.pers.posicao.y = posicaoInicialPersonagem.y;
    this.pers.indiceMovimento = 0;
    this.fitness = 0;
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
  
  void gerarObjetos(Class klass, int qtde) {
    //Object obj = klass.newInstance();
  }
}
