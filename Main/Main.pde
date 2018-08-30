import g4p_controls.*;
import grafica.*;

// variaveis relacionadas aos mapas
ArrayList<Mapa> mapas;
Mapa mapaAtual         = null;
int indiceMapa         = 0;
int qtdeMapas          = 10;
PVector posicaoInicialPersonagem = new PVector();

// tabela de mapas
TabelaMapas tabelaMapas   = new TabelaMapas();

// gerações
int geracao;
boolean novaGeracao       = false;

// grafico
GPlot grafico;
GPointsArray pontosFitness;

// variaveis de teste
boolean isDebugEnabled    = false;

// variaveis de controle
boolean jogoIniciado      = true;
boolean iniciarPosTela    = false;
boolean autoSimulate      = true;
boolean pause             = false;
boolean desenharGrid      = false;
boolean alternarGrafico   = true;
double tempoAtualizacao   = 0;
double tempoMovimentacao  = 0;
double tempoMovLimite     = 1;
int velocidadeAtualizacao = 4;
                                                                                                                                     
void setup() {
  size(1240,860);
  surface.setResizable(true);
  criarAmbiente();
  configurarGrafico();
  createGUI();
  customGUI();
}

void draw() {
  // iniciar posicao da tela
  if (!iniciarPosTela) {
    surface.setLocation(50,0);
    iniciarPosTela = true;
  }
  
  clear();
  background(color(25,25,25));
  atualizarGUI();
  try {
    
    if (jogoIniciado && !pause) {
      atualizarJogo();
    }
    
    tabelaMapas.desenhar();
    
    mapaAtual.desenhar();
    if (alternarGrafico) {
      desenharGrafico();
    } else {
      mapaAtual.tamanhoCelula = 18;
    }
    
  } catch(Exception e) {
    e.printStackTrace();
    exit();
  }
}
