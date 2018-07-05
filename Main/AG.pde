int fitness = 0;

void calcularFitness(Mapa mapa) {
  Personagem pers = mapa.pers;
  ArrayList<Inimigo> inimigos = mapa.inimigos;
  ArrayList<Coletavel> coletaveis = mapa.coletaveis;
  ArrayList<GameObject> objetos = new ArrayList<GameObject>();
  
  objetos.addAll(inimigos);
  objetos.addAll(coletaveis);
  
  for (GameObject objeto : objetos) {
    if (pers.posicao.x == objeto.posicao.x && pers.posicao.y == objeto.posicao.y) {
      if (objeto.etiqueta == "inimigo") {
        mapa.fitness -= 2;
      } else if (objeto.etiqueta == "coletavel") {
        mapa.fitness += 2;
      } else if (objeto.etiqueta == "vazio") {
        mapa.fitness += 1;
      }
    }
  }
  
  ordenarMapasPorFitness();
}

void crossOver() {
  int qtdeMelhoresFitness = 4;
  HashMap<Integer, Integer> mapIndicesFitness = getMelhoresFitness(qtdeMelhoresFitness);
  
  Mapa mapa1;
  Mapa mapa2;
  int[] movimentos1;
  int[] movimentos2;
  
  int qtdeMovimentos = mapas.get(0).pers.qtdeMovimentos;
  ArrayList<ArrayList<Integer>> novosMovimentos = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> novoMovimento = new ArrayList<Integer>(qtdeMovimentos);
  
  for (int i = 0; i < qtdeMelhoresFitness - 1; i++) {
    mapa1 = mapas.get(mapIndicesFitness.get(i));
    movimentos1 = mapa1.pers.movimentos;
    
    for (int j = i+1; j < qtdeMelhoresFitness; j++) {
      mapa2 = mapas.get(mapIndicesFitness.get(j));
      movimentos2 = mapa2.pers.movimentos;
      
      novoMovimento.clear(); // limpar o arranjo de movimentos para proxima iteracao
      for(int k = 0; k < qtdeMovimentos; k++) {
        if (k < qtdeMovimentos / 2) {   
          novoMovimento.add(movimentos1[k]);
        } else {
          novoMovimento.add(movimentos2[k]);
        }
      }
      novosMovimentos.add(novoMovimento);
    }
  }
  
  for (int i = 0; i < novosMovimentos.size(); i++) {
    for (int j = 0; j < qtdeMovimentos; j++) {
      mapas.get(i).pers.movimentos[j] = novosMovimentos.get(i).get(j);
      realizarMutacao(mapas.get(i));
    }
  }
  
  // resetar Posicoes das celulas
  for (int i = 0; i < mapas.size(); i++) {
    mapas.get(i).resetarValores();
  }
}

void realizarMutacao(Mapa mapa) {
  int indiceMutacao = (int) random(0, mapa.pers.movimentos.length);
  mapa.pers.movimentos[indiceMutacao] = (int) random(1, 9);
}

int preverFitness(Mapa mapa) {
  
  int fitness = 0;
  
  PVector posicao = new PVector();
  posicao.x = mapa.pers.posicao.x;
  posicao.y = mapa.pers.posicao.y;
  int[] movimentos = mapa.pers.movimentos;
  
  ArrayList<Inimigo> inimigos = mapa.inimigos;
  ArrayList<Coletavel> coletaveis = mapa.coletaveis;
  ArrayList<GameObject> objetos = new ArrayList<GameObject>();
  
  objetos.addAll(inimigos);
  objetos.addAll(coletaveis);
  
  for (int i = 0; i < movimentos.length; i++) {
    movimentar(posicao, movimentos[i]);
    
    // verificar posicao com um conjunto de objetos
    for (GameObject objeto : objetos) {
      if (posicao.x == objeto.posicao.x && posicao.y == objeto.posicao.y) {
        if (objeto.etiqueta == "inimigo") {
          fitness -= 2;
        } else if (objeto.etiqueta == "coletavel") {
          fitness += 2;
        } else if (objeto.etiqueta == "vazio") {
          fitness += 1;
        }
      }
    }
  }
  return fitness;
}
