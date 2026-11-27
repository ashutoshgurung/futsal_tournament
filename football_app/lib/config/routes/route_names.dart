class RouteNames {
  static const splash = '/splash';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const forgotPasswordSent = '/forgot-password/sent';
  static const home = '/'; // BottomNavigationScreen
  static const profile = '/profile';
  static const myRegistration = '/my-registration';
  static const becomeOrganizer = '/become-organizer';
  static const organizer = '/organizer'; // OrganizerShellScreen
  static const tieSheets = '/tournaments/:tournamentId/tie-sheets';
static const tieSheetCreate = '/tournaments/:tournamentId/tie-sheets/create';
static const tieSheetDetail = '/tie-sheets/:id';
static const tournamentDetail = '/tournaments/:id';
  static const tournamentCreate = '/tournaments/create';
  static const tournamentEdit = '/tournaments/:id/edit';
  static const tournamentRegistration = '/tournaments/:id/registration';
  static const tournamentRegistrationEdit = '/tournaments/:id/registration/edit';

  static String tieSheetsOf(String tournamentId) => '/tournaments/$tournamentId/tie-sheets';
static String tieSheetCreateOf(String tournamentId) => '/tournaments/$tournamentId/tie-sheets/create';
static String tieSheetDetailOf(String id) => '/tie-sheets/$id';
}
