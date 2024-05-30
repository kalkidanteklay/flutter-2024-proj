import 'package:equatable/equatable.dart';
import 'package:pets/adoption_application/model.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class FetchApplications extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class FetchAllApplications extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class LoadApplications extends ApplicationEvent {}

class AddApplication extends ApplicationEvent {
  final Application application;

  const AddApplication(this.application);

  @override
  List<Object> get props => [application];
}

class UpdateApplication extends ApplicationEvent {
  final String id;
  final Application application;

  const UpdateApplication(this.application, this.id);

  @override
  List<Object> get props => [application];
}

class DeleteApplication extends ApplicationEvent {
  final String id;

  const DeleteApplication(this.id);

  @override
  List<Object> get props => [id];
}
