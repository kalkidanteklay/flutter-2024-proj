import 'package:bloc/bloc.dart';
import 'package:pets/adoption_application/repository.dart';
import 'package:pets/adoption_application/events.dart';
import 'package:pets/adoption_application/states.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final ApplicationRepository applicationRepository;

  ApplicationBloc(this.applicationRepository) : super(ApplicationInitial()) {
    on<LoadApplications>((event, emit) async {
      emit(ApplicationLoading());
      try {
        final applications = await applicationRepository.getApplications();
        emit(ApplicationLoaded(applications));
      } catch (e) {
        emit(ApplicationError(e.toString()));
      }
    });

    on<AddApplication>((event, emit) async {
      try {
        await applicationRepository.addApplication(event.application);
        final applications = await applicationRepository.getApplications();
        emit(ApplicationLoaded(applications));
      } catch (e) {
        emit(ApplicationError(e.toString()));
      }
    });

    on<UpdateApplication>((event, emit) async {
      try {
        await applicationRepository.updateApplication(
            event.application, event.id);
        final applications = await applicationRepository.getApplications();
        emit(ApplicationLoaded(applications));
      } catch (e) {
        emit(ApplicationError(e.toString()));
      }
    });
    on<FetchApplications>((event, emit) async {
      try {
        final applications = await applicationRepository.getApplications();
        emit(ApplicationLoaded(applications));
      } catch (e) {
        emit(ApplicationError(e.toString()));
      }
    });
    on<FetchAllApplications>((event, emit) async {
      try {
        final applications = await applicationRepository.getAllApplications();
        emit(ApplicationLoaded(applications));
      } catch (e) {
        emit(ApplicationError(e.toString()));
      }
    });

    on<DeleteApplication>((event, emit) async {
      try {
        await applicationRepository.deleteApplication(event.id);
        final applications = await applicationRepository.getApplications();
        emit(ApplicationLoaded(applications));
      } catch (e) {
        emit(ApplicationError(e.toString()));
      }
    });
  }
}
