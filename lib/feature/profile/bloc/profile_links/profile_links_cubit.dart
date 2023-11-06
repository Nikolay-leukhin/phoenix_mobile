import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_links_state.dart';

class ProfileLinksCubit extends Cubit<ProfileLinksState> {
  ProfileLinksCubit() : super(ProfileLinksInitial());

  void loadLink(String url) async {
    try {
      print(url);
      await launchUrl(Uri.parse(url));
      emit(ProfileLinksSuccess());
    } catch (ex) {
      print(ex);
      emit(ProfileLinksFail());
    }
  }
}
