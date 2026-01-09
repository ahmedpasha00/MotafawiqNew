import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/repo/total_students_repo.dart';

part 'total_students_state.dart';

class TotalStudentsCubit extends Cubit<TotalStudentsState> {
  final TotalStudentsRepo repository;
  late final Stream<int> _stream;

  TotalStudentsCubit({required this.repository}) : super(TotalStudentsInitial()) {
    // هنا بنعمل الاشتراك في Stream
    _stream = repository.getTotalStudentsStream();
    _stream.listen(
          (total) {
        emit(TotalStudentsSuccess(total));
      },
      onError: (e) {
        emit(TotalStudentsError(e.toString()));
      },
    );
  }
}