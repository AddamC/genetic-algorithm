HashMap<Integer, Integer> mapasFitness = null; //new HashMap<Integer, Integer>(); // ordem de maior fitness, indice do mapa em "mapas"
    
void ordenarMapasPorFitnessAtual() {
  mapasFitness = new HashMap<Integer, Integer>();
  for (int i = 0; i < 4; i++) {
    Mapa mapaFitness = mapas.get(0);
    for (int k = 0; k < mapas.size(); k++) {
      if (!mapasFitness.containsValue(k)) {
        if (mapas.get(k).fitness > mapaFitness.fitness) {
          mapaFitness = mapas.get(k);
        }
      }
    }
    mapasFitness.put(i, mapas.indexOf(mapaFitness));
  }
}

void ordenarMapasPorFitness() {
  mapasFitness = new HashMap<Integer, Integer>();
  for (int i = 0; i < 4; i++) {
    Mapa mapaFitness = mapas.get(0);
    for (int k = 0; k < mapas.size(); k++) {
      if (!mapasFitness.containsValue(k)) {
        if (mapas.get(k).fitnessTotal > mapaFitness.fitnessTotal) {
          mapaFitness = mapas.get(k);
        }
      }
    }
    mapasFitness.put(i, mapas.indexOf(mapaFitness));
  }
}

Mapa gerarNovoMapa(Mapa mapa) {
  return new Mapa(mapa.pers, mapa.inimigos, mapa.coletaveis);
}

HashMap<Integer, Integer> getMelhoresFitness(int qtde) {
  
  HashMap<Integer, Integer> mapIndicesFitness = new HashMap<Integer, Integer>();
  
  for (int i = 0; i < qtde; i++) {
    Mapa mapIndiceFitness = mapas.get(0);
    for (int k = 0; k < mapas.size(); k++) {
      if (!mapIndicesFitness.containsValue(k)) {
        if (mapas.get(k).fitness > mapIndiceFitness.fitness) {
          mapIndiceFitness = mapas.get(k);
        }
      }
    }
    mapIndicesFitness.put(i, mapas.indexOf(mapIndiceFitness));
  }
  return mapIndicesFitness;
}

void movimentar(PVector posicao, int movimento) {
  if (movimento == 1) {
    posicao.x += -1;
    posicao.y += -1;
  } else if (movimento == 2) {
    posicao.y += -1;
  } else if (movimento == 3) {
    posicao.x += 1;
    posicao.y += -1;
  } else if (movimento == 4) {
    posicao.x += -1;
  } else if (movimento == 5) {
    return;
  } else if (movimento == 6) {
    posicao.x += 1;
  } else if (movimento == 7) {
    posicao.x += -1;
    posicao.y += 1;
  } else if (movimento == 8) {
    posicao.y += 1;
  } else if (movimento == 9) {
    posicao.x += 1;
    posicao.y += 1;
  }
}
