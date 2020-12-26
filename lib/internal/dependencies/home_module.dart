import 'package:habr_clean_architecture/domain/state/home/home_state.dart';
import 'package:habr_clean_architecture/internal/repository_module.dart';

class HomeModule {
  static HomeState homeState() {
    return HomeState(
      RepositoryModule.dayRepository(),
    );
  }
}
