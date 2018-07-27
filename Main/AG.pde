int fitness = 0;

void calcularFitness(Mapa mapa) {
  Personagem pers = mapa.pers;
  GameObject objeto = mapa.mapObjetos.get(pers.posicao);
  
  if (objeto.etiqueta == "inimigo") {
    mapa.fitness -= 2;
  } else if (objeto.etiqueta == "coletavel") {
    mapa.fitness += 2;
  } else if (objeto.etiqueta == "vazio") {
    mapa.fitness += 1;
  }
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
  ArrayList<ArrayList<Integer>> movimentosMelhorFitness = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> movimentosArray = new ArrayList<Integer>(qtdeMovimentos);
  
  // passando valores de um arranjo primitivo para um ArrayList
  for (int i = 0; i < qtdeMelhoresFitness; i++) {
    movimentos1 = mapas.get(mapIndicesFitness.get(i)).pers.movimentos;
    for (int j = 0; j < qtdeMovimentos; j++) {
      movimentosArray.add(movimentos1[j]);
    }
    movimentosMelhorFitness.add(movimentosArray);
  }
  
  /* 
  TODO: melhorar codigo para tentar reutilizar o movimentosArray,
  pois ja contem os melhores movimentos
  */
  for (int i = 0; i < qtdeMelhoresFitness - 1; i++) {
    mapa1 = mapas.get(mapIndicesFitness.get(i));
    movimentos1 = mapa1.pers.movimentos;
    
    for (int j = i+1; j < qtdeMelhoresFitness; j++) {
      mapa2 = mapas.get(mapIndicesFitness.get(j));
      movimentos2 = mapa2.pers.movimentos;
      
      movimentosArray.clear(); // limpar o arranjo de movimentos para proxima iteracao
      for(int k = 0; k < qtdeMovimentos; k++) {
        if (k < qtdeMovimentos / 2) {   
          movimentosArray.add(movimentos1[k]);
        } else {
          movimentosArray.add(movimentos2[k]);
        }
      }
      novosMovimentos.add(movimentosArray);
    }
  }
  
  for (int i = 0, cont = 0; i < mapas.size(); i++) {
    if (i < novosMovimentos.size()) {
      for (int j = 0; j < qtdeMovimentos; j++) {
        mapas.get(i).pers.movimentos[j] = novosMovimentos.get(i).get(j);
      }
      realizarMutacao(mapas.get(i));
    } else { // preencher os mapas restantes
      for (int j = 0; j < qtdeMovimentos; j++) {
        mapas.get(i).pers.movimentos[j] = movimentosMelhorFitness.get(cont).get(j);
      }
      cont++;
    }
  }
  
  // resetar Posicoes das celulas
  for (int i = 0; i < mapas.size(); i++) {
    mapas.get(i).resetarValores();
  }
}

void realizarMutacao(Mapa mapa) {
  for (int i = 0; i < 4; i++) {  
    int indiceMutacao = (int) random(0, mapa.pers.movimentos.length);
    mapa.pers.movimentos[indiceMutacao] = (int) random(1, 9);
  }
}

void preverFitness(Mapa mapa) {
  
  int fitnessTotal = 0;
  
  PVector posicao = new PVector();
  posicao.x = mapa.pers.posicao.x;
  posicao.y = mapa.pers.posicao.y;
  int[] movimentos = mapa.pers.movimentos;
  
  for (int i = 0; i < movimentos.length; i++) {
    movimentar(posicao, movimentos[i]);
    mapa.verificarPosicaoObjeto(posicao);
    GameObject objeto = mapa.mapObjetos.get(posicao);
    
    if (objeto == null) {
      print(); //<>//
    }
    
    // verificar posicao com um conjunto de objetos
    if (objeto.etiqueta == "inimigo") {
      fitnessTotal -= 2;
    } else if (objeto.etiqueta == "coletavel") {
      fitnessTotal += 2;
    } else if (objeto.etiqueta == "vazio") {
      fitnessTotal += 1;
    }
  }
  println("\n\nfitnessTotal: " + mapa.fitnessTotal + "\nfitness: " + fitnessTotal);
  mapa.fitnessTotal = fitnessTotal;
  println("fitnessTotal: " + mapa.fitnessTotal);
}
