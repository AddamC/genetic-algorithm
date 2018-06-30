int fitness = 0;

void calcularFitness(Mapa mapa) {
  Personagem pers = mapa.pers;
  ArrayList<Inimigo> inimigos = mapa.inimigos;
  ArrayList<Coletavel> coletaveis = mapa.coletaveis;
  
  for (Inimigo inimigo : inimigos) {
    if (pers.posicao.x == inimigo.posicao.x && pers.posicao.y == inimigo.posicao.y) {
      mapa.fitness -= 2;    
    }
  }
  
  for (Coletavel coletavel : coletaveis) {
    if (pers.posicao.x == coletavel.posicao.x && pers.posicao.y == coletavel.posicao.y) {
      mapa.fitness += 2;
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
      mapa2 = mapas.get(mapIndicesFitness.get(j)); //<>//
      movimentos2 = mapa2.pers.movimentos;
      
      novoMovimento.clear();
      for(int k = 0; k < qtdeMovimentos; k++) {
        if (k < qtdeMovimentos / 2) {
          //novoMovimento.set(k, movimentos1[k]);   
          novoMovimento.add(movimentos1[k]);
        } else {
          //novoMovimento.set(k, movimentos2[k]);
          novoMovimento.add(movimentos2[k]);
        }
      }
      novosMovimentos.add(novoMovimento);
      // mutacao(mapas.get(cont)); 
    }
  }
  
  for (int i = 0; i < novosMovimentos.size(); i++) {
    for (int j = 0; j < qtdeMovimentos; j++) {
      mapas.get(i).pers.movimentos[j] = novosMovimentos.get(i).get(j); //<>//
      mutacao(mapas.get(i));
    }
  }
   //<>//
  // resetar Posicoes dos personagens
  for (int i = 0; i < mapas.size(); i++) {
    mapas.get(i).resetarValores();
  }
}

void mutacao(Mapa mapa) {
  int indiceMutacao = (int) random(0, mapa.pers.movimentos.length);
  mapa.pers.movimentos[indiceMutacao] = (int) random(1, 9);
}
