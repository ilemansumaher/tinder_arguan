import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class ControllerImage = _ControllerImageBase with _$ControllerImage;

abstract class _ControllerImageBase with Store {
  
  @observable
  int imegIndex=0;


  @action 
  void nextImage() {
    imegIndex = (imegIndex + 1) % 4;
  }


  @action 
  void prevImage() {
    imegIndex = (imegIndex - 1) % 4;
  }
}