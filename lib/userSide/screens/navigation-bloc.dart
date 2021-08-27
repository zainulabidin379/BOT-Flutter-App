import 'package:bloc/bloc.dart';
import 'screens.dart';


enum NavigationEvents {
  HomePageClickedEvent,
  MyProfileClickedEvent,
  OffersClickedEvent,
  AboutClickedEvent,
  OurTeamClickedEvent,
  SupportClickedEvent,

  SettingsClickedEvent,
  //LogoutClickedEvent,

}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);



  @override
  NavigationStates get initialState => HomeScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomeScreen();
        break;
      case NavigationEvents.MyProfileClickedEvent:
        yield MyProfile();
        break;
      case NavigationEvents.OffersClickedEvent:
        yield Offers();
        break;
      case NavigationEvents.AboutClickedEvent:
        yield AboutBOT();
        break;
      case NavigationEvents.OurTeamClickedEvent:
        yield OurTeam();
        break;
      case NavigationEvents.SupportClickedEvent:
        yield SupportScreen();
        break;
      case NavigationEvents.SettingsClickedEvent:
        yield SettingsScreen();
        break;
    }
  }
}