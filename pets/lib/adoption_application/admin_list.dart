import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pets/adoption_application/provider.dart';
import 'package:pets/adoption_application/bloc.dart';
import 'package:pets/adoption_application/states.dart';
import 'package:pets/adoption_application/repository_impl.dart';
import 'package:pets/adoption_application/events.dart';

class AdminListPage extends StatelessWidget {
  final String token;
  final String userId;

  const AdminListPage({required this.token, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (context) => ApplicationBloc(ApplicationRepositoryImpl(
              ApplicationApiProvider('http://localhost:3000', token)))
            ..add(FetchAllApplications()),
        ),
      ],
      child: blocBody(),
    );
  }

  Widget blocBody() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          if (state is ApplicationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ApplicationLoaded) {
            return ListView.builder(
              itemCount: state.applications.length,
              itemBuilder: (context, index) {
                final application = state.applications[index];
                return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          // backgroundImage: AssetImage(),
                          // backgroundColor: Colors.transparent,
                          ),
                      title: Text(application.fullName ?? ''),
                      //status: Text(application.status ?? ''),
                      //icon: application.icon,
                      subtitle: Text(application.address ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FloatingActionButton(
                              onPressed: () {}, child: Text('Approve')),
                          SizedBox(width: 10.0),
                          FloatingActionButton(
                              onPressed: () {}, child: Text('Decline')),
                        ],
                      ),
                    ));
              },
            );
          } else if (state is ApplicationError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}
