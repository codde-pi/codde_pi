import 'package:codde_pi/components/forms/store/alert_dialog_form_store.dart';
import 'package:codde_pi/core/codde_file_type.dart';
import 'package:mobx/mobx.dart';

part 'create_file_store.g.dart';

class CreateFileStore = _CreateFileStore with _$CreateFileStore;

abstract class _CreateFileStore extends AlertDialogFormStore with Store {
  @observable
  CoddeFileType fileType;

  _CreateFileStore({this.fileType = CoddeFileType.python});

  setFileType(CoddeFileType fType) {
    fileType = fType;
  }
}
