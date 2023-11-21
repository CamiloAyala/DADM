import 'package:flutter/material.dart';
import 'package:reto_8/models/company_model.dart';
import 'package:reto_8/ui/views/company_details/company_details_view.dart';
import 'package:reto_8/ui/views/company_list/company_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CompanyListView extends StatefulWidget {
  const CompanyListView({Key? key}) : super(key: key);

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {

  final CompanyListViewModel _model = CompanyListViewModel();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CompanyListViewModel(), 
      builder: (context, CompanyListViewModel model, child) => Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Companies'),
      ),
      body: FutureBuilder<List<Company>>(
        future: model.getCompanies(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data?.isEmpty == false) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data?[index].name ?? ''),
                    subtitle: Text(snapshot.data?[index].website ?? ''),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyDetailsView(company: snapshot.data![index])
                        )
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _dialogBuilder(context, snapshot.data![index]);
                      },
                    ),
                  ),
                );
              },
            );
          } else if(snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            if(model.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('No se encontraron empresas'),
              );
            }
          }
        },
      ),
      floatingActionButton: model.isLoading ? null : FloatingActionButton.extended(
        onPressed: () {
          model.navigateToCompanyForm();
        },
        label: const Text('Agregar empresa'),
        icon: const Icon(Icons.add),
      )
    ));
  }

  Future<void> _dialogBuilder(BuildContext context, Company company) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar empresa'),
          content: const Text(
            '¿Está seguro que desea eliminar la empresa? '
            'Esta acción no se puede deshacer.'
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.background,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Eliminar'),
              onPressed: () async {
                int count = await _model.deleteCompany(company.id);
                Navigator.of(context).pop();

                if(count > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Empresa eliminada'),
                    )
                  );

                  _model.reload();
                } else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al eliminar la empresa :(${company.name})}'),
                    )
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

}