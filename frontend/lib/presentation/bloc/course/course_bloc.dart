import 'package:flutter_bloc/flutter_bloc.dart';
import './course_events.dart';
import './course_states.dart';
import '../../../data/repositories/course_repository.dart';

class CourseBloc extends Bloc<CourseEvents, CourseState> {
  final CourseRepository cRepo;

  CourseBloc(this.cRepo) : super(HomeState()) {
    on<GetAvailableCourses>(onGetAvailableCourses);
    on<GetEnrolledCourses>(onGetEnrolledCourses);
    on<LoadDropPageCourses>(onLoadDropPageCourses);
    on<AddCourses>(onAddCourses);
    on<DropCourse>(onDropCourse);
    on<BackToHome>((event, emit) {
      emit(HomeState());
    });
  }

  Future<void> onGetEnrolledCourses(GetEnrolledCourses event,Emitter<CourseState> emit,) async {
    emit(LoadingState());
    try {
      final enrolledCourses = await cRepo.getEnrolledCourses();
      emit(EnrolledPageState(enrolledCourses));
    } catch (error) {
      emit(EnrollError(error.toString()));
    }
  }

  Future<void> onLoadDropPageCourses(LoadDropPageCourses event,Emitter<CourseState> emit,) async {
    emit(LoadingState());
    try {
      final enrolledCourses = await cRepo.getEnrolledCourses();
      emit(DropPageState(enrolledCourses)); 
    } catch (error) {
      emit(DropError(error.toString()));
    }
  }

  Future<void> onAddCourses(AddCourses event, Emitter<CourseState> emit) async {
    emit(LoadingState());
    try {
      print("adding courses in process");
      print(event.courses);
      final succ = await cRepo.addCourses(event.courses);
      if (succ) {
        final courses = await cRepo.getAvailableCourses();
        print(courses.length);
        emit(AvailablePageState(courses));
      } else {
        emit(EnrollError("enrollment error"));
      }
    } catch (error) {
      emit(EnrollError(error.toString()));
    }
  }

  Future<void> onDropCourse(DropCourse event, Emitter<CourseState> emit) async {
    emit(LoadingState());
    try {
      final succ = await cRepo.dropCourse(event.course);
      if (succ) {
        final courses = await cRepo.getEnrolledCourses();
        emit(DropPageState(courses));
      } else {
        emit(DropError("error occurred while dropping course"));
      }
    } catch (error) {
      emit(DropError(error.toString()));
    }
  }

  Future<void> onGetAvailableCourses(
    GetAvailableCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(LoadingState());
    try {
      final courses = await cRepo.getAvailableCourses();
      emit(AvailablePageState(courses));
    } catch (error) {
      emit(AvailError(error.toString()));
    }
  }
}
