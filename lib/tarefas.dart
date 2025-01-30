class Tarefas {
  List<String> aFazer = [];
  List<String> fazendo = [];
  List<String> feito = [];

  void adicionar(String tarefa) {
    aFazer.add(tarefa);
  }

  void remover(String tarefa, String tipo) {
    if (tipo == 'a fazer') {
      aFazer.remove(tarefa);
    } else if (tipo == 'fazendo') {
      fazendo.remove(tarefa);
    } else if (tipo == 'feito') {
      feito.remove(tarefa);
    }
  }

  void mover(String tarefa, String tipo) {
    if (tipo == 'a fazer') {
      aFazer.remove(tarefa);
      fazendo.add(tarefa);
    } else if (tipo == 'fazendo') {
      fazendo.remove(tarefa);
      feito.add(tarefa);
    }
  }
  
  // método para atualizar uma tarefa
  // método para validar o texto escrito na tarefa
}
