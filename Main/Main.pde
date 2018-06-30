// variaveis relacionadas aos mapas
ArrayList<Mapa> mapas = new ArrayList<Mapa>();
Mapa mapaAtual = null;
int indiceMapa = 0;
int qtdeMapas = 10;
PVector posicaoInicialPersonagem;

// tabela de mapas
TabelaMapas tabelaMapas = new TabelaMapas();

// gerações
int geracao = 0;
boolean novaGeracao = false;

// variaveis de teste
boolean isDebugEnabled = false;

// variaveis de controle
boolean autoSimulate = false;
double tempoAtualizacao = 0;
int velocidadeAtualizacao = 1;
                                                                                                                                     
void setup() {
  size(1024,740);
  surface.setResizable(true);
  criarMapas();
}

void draw() {
  clear();
  fill(255,255,255);
  textSize(15);
  text("mapa: " + (indiceMapa+1), 10, 530);
  text("fitness: " + mapas.get(indiceMapa).fitness, 10, 550);
  text("geracao: " + geracao, 10, 570);
  text("qtde de mapas: " + mapas.size(), 10, 590);
  text("contador de movimentos: " + mapaAtual.pers.indiceMovimento, 10, 610);
  text("Simulacao Automatica: " + (autoSimulate ? "ligada" : "desligada"), 10, 630);
  text("tempo de atualização: " + (int)tempoAtualizacao, 10, 650);
  try {
    tabelaMapas.desenhar();
    mapaAtual.desenhar();
    
    atualizarJogo();
  } catch(Exception e) {
    e.printStackTrace();
    exit();
  }
}

void criarMapas() {
  mapas.add(new Mapa());
  mapaAtual = mapas.get(0);
  posicaoInicialPersonagem = new PVector();
  posicaoInicialPersonagem.x = mapas.get(0).pers.posicao.x;
  posicaoInicialPersonagem.y = mapas.get(0).pers.posicao.y;
  for (int i = 1; i < 10; i++) {
    mapas.add(new Mapa(mapaAtual.pers, mapaAtual.inimigos, mapaAtual.coletaveis));
  }
}

void gerarNovaGeracao() {
  crossOver();
  geracao = geracao + 1;
  novaGeracao = false;
  mapaAtual = mapas.get(0);
}

void atualizarJogo() {
    
    if (tempoAtualizacao > 20 || mousePressed && mapaAtual.pers.emMovimento == false) {
      tempoAtualizacao = 0;
      for (Mapa mapa : mapas) {
        mapa.pers.emMovimento = true;
        mapa.resetarValores();
      }
    }
    for (Mapa mapa : mapas) {
      mapa.atualizar();
    }
    
    // realizar a nova geração
    if(novaGeracao) {
      gerarNovaGeracao();
    }
    
    if (mapaAtual.pers.emMovimento == false && autoSimulate) {
      tempoAtualizacao += 0.1;
    }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (indiceMapa > 0) {
        indiceMapa--;
        mapaAtual = mapas.get(indiceMapa);
      }
    } else if (keyCode == RIGHT) {
      if (indiceMapa < mapas.size() - 1) {
        indiceMapa++;
        mapaAtual = mapas.get(indiceMapa);
      }
    } else if (keyCode == UP) {
      novaGeracao = true;
    } else if (keyCode == DOWN) {
      autoSimulate = !autoSimulate;
      tempoAtualizacao = 0;
    }
  }
}
