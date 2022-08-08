import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/data/models/user_model.dart';
import 'package:jsonplaceholder_app/presentation/generic_bloc_listener.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "website": user.website,
      "company.name": user.company.name,
      "company.bs": user.company.bs,
      "company.catchPhrase": user.company.catchPhrase,
      "address.city": user.address.city,
      "address.street": user.address.street,
      "address.suite": user.address.suite,
      "address.zipcode": user.address.zipcode,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: GenericBlocListener(
        child: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Key',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Value',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: data.entries
                .map<DataRow>(
                  (e) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(e.key)),
                      DataCell(Text(e.value)),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
