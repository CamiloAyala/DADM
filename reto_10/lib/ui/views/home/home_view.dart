import 'package:flutter/material.dart';
import 'package:reto_10/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final HomeViewModel viewModel = HomeViewModel();
  List<dynamic> openData = [];

  @override
  void initState(){
    super.initState();
    getData();    
  }

  void getData() async {
    final response = await viewModel.getOpenData();

    setState(() {
      openData = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Reto 10',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Año',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: viewModel.changeYear,
                              controller: viewModel.yearController,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Trimestre',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: viewModel.changeQuarter,
                              controller: viewModel.quarterController,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre',
                          ),
                          keyboardType: TextInputType.name,
                          onChanged: viewModel.changeName,
                          controller: viewModel.nameController,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tecnología',
                              ),
                              keyboardType: TextInputType.name,
                              onChanged: viewModel.changeTecnology,
                              controller: viewModel.tecnologyController,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Segmento',
                              ),
                              keyboardType: TextInputType.name,
                              onChanged: viewModel.changeSegment,
                              controller: viewModel.segmentController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final response = await viewModel.getOpenData();

                          setState(() {
                            openData = response;
                          });
                        },
                        label: const Text('Consultar'),
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: viewModel.cleanValues,
                        label: const Text('Limpiar'),
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${openData.length} resultados',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text('Año'),
                      ),
                      DataColumn(
                        label: Text('Trimestre'),
                      ),
                      DataColumn(
                        label: Text('Nombre'),
                      ),
                      DataColumn(
                        label: Text('Tecnología'),
                      ),
                      DataColumn(
                        label: Text('Segmento'),
                      ),
                    ],
                    rows: openData
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text(e['a_o'].toString()),
                              ),
                              DataCell(
                                Text(e['trimestre'].toString()),
                              ),
                              DataCell(
                                Text(e['proveedor'].toString()),
                              ),
                              DataCell(
                                Text(e['tecnolog_a'].toString()),
                              ),
                              DataCell(
                                Text(e['segmento'].toString()),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        )),
    );
  }
}
