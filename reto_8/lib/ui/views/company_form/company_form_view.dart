import 'package:flutter/material.dart';
import 'package:reto_8/ui/views/company_form/company_form_viewmodel.dart';
import 'package:reto_8/ui/widgets/entry_field.dart';
import 'package:reto_8/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

class CompanyFormView extends StatefulWidget {
  const CompanyFormView({Key? key}) : super(key: key);

  @override
  State<CompanyFormView> createState() => _CompanyFormViewState();
}

class _CompanyFormViewState extends State<CompanyFormView> {
  @override
  Widget build(BuildContext context) {
    SnackBar snackBar;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CompanyFormViewModel(),
      builder: (context, CompanyFormViewModel model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Company'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // const SizedBox(height: 100),

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Registrar Empresa',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontFamily: "Lato",
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),

              Form(
                child: Column(children: [
                  const SizedBox(height: 20),
                  EntryField(
                    padding: 32,
                    labelText: 'Nombre',
                    textType: TextInputType.name,
                    onChanged: model.changeName,
                  ),
                  EntryField(
                    padding: 24,
                    labelText: 'Url',
                    textType: TextInputType.url,
                    onChanged: model.changeWebsite,
                  ),
                  EntryField(
                    padding: 24,
                    labelText: 'Telefono',
                    textType: TextInputType.phone,
                    onChanged: model.changePhone,
                  ),
                  EntryField(
                    padding: 24,
                    labelText: 'Email 2',
                    textType: TextInputType.emailAddress,
                    onChanged: model.changeEmail,
                  ),
                  EntryField(
                    padding: 24,
                    labelText: 'Productos',
                    textType: TextInputType.text,
                    onChanged: model.changeProducts,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: DropdownButtonFormField(
                      hint: const Text('Tipo de empresa'),
                      onChanged: model.changeType,
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

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SubmitButton(
                  text: 'Registrar',
                  textColor: Theme.of(context).colorScheme.tertiary,
                  buttonColor: Theme.of(context).colorScheme.inversePrimary,
                  onPressed: () async {
                    int id = await model.createCompany();

                    if(id > 0) {
                      snackBar = const SnackBar(
                        content: Text('Empresa registrada'),
                      );
                    } else {
                      snackBar = const SnackBar(
                        content: Text('Error al registrar empresa'),
                        backgroundColor: Colors.red,
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              )
            ],
          ),
        )),
    );
  }
}
