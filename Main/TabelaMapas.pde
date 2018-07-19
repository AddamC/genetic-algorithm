class TabelaMapas {
  int largura, altura;
  PVector posicaoGrid = new PVector();
  
  // Celulas
  int qtdeCelulas;
  int fitness;
  int rankCelula;
  String descricao;
  String descPosicaoCelula;
  
  TabelaMapas() {
    this.qtdeCelulas = 4;
    
    this.posicaoGrid.x = 500;
    this.posicaoGrid.y = 25;
    this.largura = 500;
    this.altura = this.qtdeCelulas * 95;   
  }
  
  void atualizar() {
  }
  
  void desenhar() {
    fill(color(150,150,150,150));
    rect(this.posicaoGrid.x, this.posicaoGrid.y, this.largura, this.altura);
    descricao = "";
    
    // TODO: melhorar posicionamento das celulas
    if (mapasFitness != null) {
      for (int i = 0; i < 4; i++) {
        fill(color(255,255,255));
        rect(this.posicaoGrid.x, this.posicaoGrid.y + (i * 95), this.largura, 95);
        fill(color(0,0,0));
        
        descricao = "Mapa: " + mapasFitness.get(i) +
             "    Fitness total: " + mapas.get(mapasFitness.get(i)).fitnessTotal +
             "    Fitness: " + mapas.get(mapasFitness.get(i)).fitness;
        
        text(i + 1 + "º", this.posicaoGrid.x + 10, i * 95 + 60);
        text(descricao, this.posicaoGrid.x + 10, i * 95 + 100);
      }
    }   
  }
}
