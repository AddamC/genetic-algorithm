import g4p_controls.*;

// variaveis relacionadas aos mapas
ArrayList<Mapa> mapas  = new ArrayList<Mapa>();
Mapa mapaAtual         = null;
int indiceMapa         = 0;
int qtdeMapas          = 10;
PVector posicaoInicialPersonagem = new PVector();

// tabela de mapas
TabelaMapas tabelaMapas   = new TabelaMapas();

// gerações
int geracao = 0;
boolean novaGeracao       = false;

// variaveis de teste
boolean isDebugEnabled    = false;

// variaveis de controle
boolean iniciarPosTela    = false;
boolean autoSimulate      = true;
boolean pause             = false;
boolean desenharGrid      = false;
double tempoAtualizacao   = 0;
double tempoMovimentacao  = 0;
double tempoMovLimite     = 1;
int velocidadeAtualizacao = 4;
                                                                                                                                     
void setup() {
  size(1024,740);
  surface.setResizable(true);
  criarMapas();
  createGUI();
  customGUI();
}

void draw() {
  // iniciar posicao da tela
  if (!iniciarPosTela) {
    surface.setLocation(200,0);
    iniciarPosTela = true;
  }
  
  if (geracao > 4) {
    println("teste");
  }
  
  clear();
  background(color(25,25,25));
  atualizarGUI();
  if (isDebugEnabled) {
    desenharTexto();
  }
  try {
    if (!pause) {
      atualizarJogo();
    }
    tabelaMapas.desenhar();
    mapaAtual.desenhar();
    
  } catch(Exception e) {
    e.printStackTrace();
    exit();
  }
}
