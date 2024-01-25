import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/errors/failure.dart';

abstract class LocalFileAccess {
  Future<Either<Failure, FileDetils>> pickImage();
}

@Injectable(as: LocalFileAccess)
class LocalFileAccessImpl implements LocalFileAccess {
  final FilePicker picker;

  LocalFileAccessImpl({required this.picker});
  @override
  Future<Either<Failure, FileDetils>> pickImage() async {
    var result =
        await picker.pickFiles(allowMultiple: false, type: FileType.image);
    if (result != null && result.files.first.path != null) {
      var data = result.files.first;
      return right(
          FileDetils(path: data.path ?? '', name: data.name, size: data.size));
    } else {
      return left(
          DatabaseFailure(errorMessage: 'we couldnt access local storage'));
    }
  }
}

class FileDetils {
  final String path;
  final String name;
  final int? size;

  FileDetils({required this.path, required this.name, this.size});
}
