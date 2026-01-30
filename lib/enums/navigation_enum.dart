enum NavigationPage {
  home,
  tracking,
  hives,
  classroom,
  calendar,
  recentChanges,
  summary,
  settings,
  profile,
  addTasks,
}

extension NavigationPageExtension on NavigationPage {
  String get title {
    switch (this) {
      case NavigationPage.home:
        return 'Home';
      case NavigationPage.tracking:
        return 'Tracking';
      case NavigationPage.hives:
        return 'Hives';
      case NavigationPage.classroom:
        return 'Classroom';
      case NavigationPage.calendar:
        return 'Calendar';
      case NavigationPage.recentChanges:
        return 'Recent Changes';
      case NavigationPage.summary:
        return 'Summary';
      case NavigationPage.settings:
        return 'Settings';
      case NavigationPage.profile:
        return 'Profile';
      case NavigationPage.addTasks:
        return 'Add Tasks';
    }
  }

  int get mainTabIndex {
    switch (this) {
      case NavigationPage.home:
        return 0;
      case NavigationPage.tracking:
        return 1;
      case NavigationPage.hives:
        return 2;
      case NavigationPage.classroom:
        return 3;
      case NavigationPage.calendar:
        return 4;
      default:
        return -1;
    }
  }

  bool get isMainPage {
    return mainTabIndex != -1;
  }
}
