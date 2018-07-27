class Personagem extends GameObject {
  int movimentos[];
  int qtdeMovimentos;
  int indiceMovimento = 0;
  boolean emMovimento = false;
  
  Personagem() {
    this.etiqueta = "personagem";
    this.cor = color(0,255,0);
    this.qtdeMovimentos = 30;
    movimentos = new int[qtdeMovimentos];
  }
  
  // 7  8  9    ↖  ↑  ↗
  // 4  5  6    ←  N  →
  // 1  2  3    ↙  ↓  ↘
  void criarMovimentos() {
    for (int i = 0; i < qtdeMovimentos; i++) {
      this.movimentos[i] = (int) random(1, 9);
    }
  }
  
  void movimentar() {
    int movimento = this.movimentos[indiceMovimento];
    
    if (movimento == 1) {
      this.posicao.x += -1;
      this.posicao.y += -1;
    } else if (movimento == 2) {
      this.posicao.y += -1;
    } else if (movimento == 3) {
      this.posicao.x += 1;
      this.posicao.y += -1;
    } else if (movimento == 4) {
      this.posicao.x += -1;
    } else if (movimento == 5) {
      return;
    } else if (movimento == 6) {
      this.posicao.x += 1;
    } else if (movimento == 7) {
      this.posicao.x += -1;
      this.posicao.y += 1;
    } else if (movimento == 8) {
      this.posicao.y += 1;
    } else if (movimento == 9) {
      this.posicao.x += 1;
      this.posicao.y += 1;
    }
  }
}
