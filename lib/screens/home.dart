import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/tarefas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  final tarefas = Tarefas();

  void criandoTarefa() {
    final TextEditingController _atividade = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Digite sua tarefa'),
        content: TextField(
          controller: _atividade,
          decoration: const InputDecoration(hintText: 'Digite aqui'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  if (_atividade.text.isNotEmpty) {
                    tarefas.adicionar(_atividade.text);
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('CONFIMAR')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCELAR'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Container(
        color: Colors.red.shade100,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.aFazer.isEmpty ? 1 : tarefas.aFazer.length,
                itemBuilder: (context, index) {
                  if (tarefas.aFazer.isEmpty) {
                    return const Center(
                      heightFactor: 25,
                      child: Text('Nada por aqui'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: Text(tarefas.aFazer[index]),
                          onTap: () {
                            bool excluir = false;
                            bool marcarFazendo = false;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                    Text('Tarefa: "${tarefas.aFazer[index]}"'),
                                content: StatefulBuilder(
                                  builder: (context, setDialogState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Remover'),
                                            Checkbox(
                                              value: excluir,
                                              onChanged: (value) {
                                                setDialogState(() {
                                                  excluir = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('Marcar como "Fazendo"'),
                                            Checkbox(
                                              value: marcarFazendo,
                                              onChanged: (value) {
                                                setDialogState(() {
                                                  marcarFazendo = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (excluir == true &&
                                          marcarFazendo == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Erro: Escolha "Marcar como Fazendo" ou "Remover"!'),
                                          backgroundColor: Colors.red,
                                        ));
                                        Navigator.of(context).pop();
                                      } else {
                                        if (excluir) {
                                          setState(() {
                                            tarefas.remover(
                                                tarefas.aFazer[index],
                                                'a fazer');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Tarefa removida com sucesso!'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          });
                                        }
                                        if (marcarFazendo) {
                                          setState(() {
                                            // método para trocar tarefas de sessão
                                            tarefas.mover(tarefas.aFazer[index],
                                                'a fazer');
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('CONFIRMAR'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('CANCELAR'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      criandoTarefa();
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        color: const Color.fromARGB(255, 236, 230, 174),
        alignment: Alignment.center,
        child: Expanded(
          child: ListView.builder(
            itemCount: tarefas.fazendo.isEmpty ? 1 : tarefas.fazendo.length,
            itemBuilder: (context, index) {
              if (tarefas.fazendo.isEmpty) {
                return const Center(
                  heightFactor: 25,
                  child: Text('Nada por aqui'),
                );
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: ListTile(
                        title: Text(tarefas.fazendo[index]),
                        onTap: () {
                          bool remover = false;
                          bool marcarFeito = false;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                                  Text('Tarefa: "${tarefas.fazendo[index]}"'),
                              content: StatefulBuilder(
                                  builder: (context, setDialogState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Remover'),
                                        Checkbox(
                                          value: remover,
                                          onChanged: (value) {
                                            setDialogState(() {
                                              remover = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Marcar como Feita'),
                                        Checkbox(
                                          value: marcarFeito,
                                          onChanged: (value) {
                                            setDialogState(() {
                                              marcarFeito = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (remover == true &&
                                        marcarFeito == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Erro: Escolha "Marcar como Fazendo" ou "Remover"!'),
                                        backgroundColor: Colors.red,
                                      ));
                                      Navigator.of(context).pop();
                                    } else {
                                      if (remover) {
                                        setState(() {
                                          tarefas.remover(
                                              tarefas.fazendo[index],
                                              'fazendo');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Tarefa removida com sucesso!'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        });
                                      }
                                      if (marcarFeito) {
                                        setState(() {
                                          tarefas.mover(tarefas.fazendo[index],
                                              'fazendo');
                                        });
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text('CONFIRMAR'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCELAR'),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                );
              }
            },
          ),
        ),
      ),
      Container(
        color: const Color.fromARGB(255, 170, 231, 172),
        alignment: Alignment.center,
        child: Expanded(
          child: ListView.builder(
            itemCount: tarefas.feito.isEmpty ? 1 : tarefas.feito.length,
            itemBuilder: (context, index) {
              if (tarefas.feito.isEmpty) {
                return const Center(
                  heightFactor: 25,
                  child: Text('Nada por aqui'),
                );
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: ListTile(
                      title: Text('Tarefa: "${tarefas.feito[index]}"'),
                      onTap: () {
                        bool remover = false;
                        bool concluida = false;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content:
                                StatefulBuilder(builder: (context, setDialog) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      const Text('Remover'),
                                      Checkbox(
                                        value: remover,
                                        onChanged: (value) {
                                          setDialog(() {
                                            remover = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Marcar como concluída'),
                                      Checkbox(
                                        value: concluida,
                                        onChanged: (value) {
                                          setDialog(() {
                                            concluida = value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    //caso remover e concluida estejam ambas marcadas
                                    if (remover == true && concluida == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Erro: Escolha "Marcar como Fazendo" ou "Remover"!'),
                                        backgroundColor: Colors.red,
                                      ));
                                      Navigator.of(context).pop();
                                    } else {
                                      if (remover) {
                                        setState(() {
                                          tarefas.remover(
                                              tarefas.feito[index], 'feito');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Tarefa excluída com sucesso!'),
                                            backgroundColor: Colors.green,
                                          ));
                                        });
                                      }
                                      if (concluida) {
                                        setState(() {
                                          tarefas.remover(
                                              tarefas.feito[index], 'feito');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Tarefa realizada com sucesso!')));
                                        });
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text('CONFIRMAR')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('CANCELAR')),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do App',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        shadowColor: Colors.black,
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.lightBlue,
            labelType: NavigationRailLabelType.all,
            selectedIndex: index,
            onDestinationSelected: (int index) => setState(() {
              this.index = index;
            }),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedIconTheme: const IconThemeData(color: Colors.white60),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white60),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.article),
                label: Text('A fazer'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.border_color_outlined),
                label: Text('Fazendo'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.assignment_turned_in_outlined),
                label: Text('Feito'),
              )
            ],
          ),
          Expanded(child: screens[index])
        ],
      ),
    );
  }
}
