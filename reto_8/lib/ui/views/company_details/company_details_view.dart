import 'package:flutter/material.dart';
import 'package:reto_8/models/company_model.dart';
import 'package:reto_8/ui/views/company_details/company_details_viewmodel.dart';
import 'package:reto_8/ui/widgets/entry_field.dart';
import 'package:reto_8/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

class CompanyDetailsView extends StatefulWidget {
  const CompanyDetailsView({Key? key, required this.company}) : super(key: key);

  final Company company;

  @override
  State<CompanyDetailsView> createState() => _CompanyDetailsViewState();
}

class _CompanyDetailsViewState extends State<CompanyDetailsView> {
  
  late Company company;

  final CompanyDetailsViewModel _model = CompanyDetailsViewModel();

  @override
  void initState() {
    super.initState();
    company = widget.company;
    _model.setCompanyInfo = company;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => _model,
      builder: (context, CompanyDetailsViewModel model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Información de la empresa'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Form(
                      child: Column(children: [
                        const SizedBox(height: 20),
                        EntryField(
                          padding: 32,
                          labelText: 'Nombre',
                          textType: TextInputType.name,
                          initialValue: company.name,
                          onChanged: model.changeName,
                          disabled: model.isDisabled,
                        ),
                        EntryField(
                          padding: 24,
                          labelText: 'Url',
                          textType: TextInputType.url,
                          initialValue: company.website,
                          onChanged: model.changeWebsite,
                          disabled: model.isDisabled,
                        ),
                        EntryField(
                          padding: 24,
                          labelText: 'Correo',
                          textType: TextInputType.emailAddress,
                          initialValue: company.email,
                          onChanged: model.changeEmail,
                          disabled: model.isDisabled,
                        ),
                        EntryField(
                          padding: 24,
                          labelText: 'Teléfono',
                          textType: TextInputType.phone,
                          initialValue: company.phone,
                          onChanged: model.changePhone,
                          disabled: model.isDisabled,
                        ),
                        EntryField(
                          padding: 24,
                          labelText: 'Productos',
                          textType: TextInputType.emailAddress,
                          initialValue: company.products,
                          onChanged: model.changeProducts,
                          disabled: model.isDisabled,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: DropdownButtonFormField(
                            hint: const Text('Tipo de empresa'),
                            onChanged: model.changeType,
                            value: model.type,
                            items: model.companyTypes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ]),
                    ),
                    model.isDisabled
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: SubmitButton(
                              text: 'Registrar',
                              textColor: Colors.white,
                              buttonColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              onPressed: () async {
                                model.setCompanyId = company.id;
                                int editCount = await model.editCompany();
                                if (editCount > 0) {
                                  model.navigateToCompanyList();
                                }
                              },
                            ),
                          )
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.toggleDisabled();
            },
            child: model.isDisabled
                ? const Icon(Icons.edit)
                : const Icon(Icons.cancel),
          )),
    );
  }
}
