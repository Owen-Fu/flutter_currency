mixin AvoidFastButtonClickMixin {
  final List<DateTime> lastClick = [];

  bool isRedundantClick(DateTime currentTime, {int shouldWaitSeconds = 2}) {
    if (lastClick.isEmpty) {
      lastClick.add(currentTime);
      return false;
    }
    if (currentTime.difference(lastClick.first).inSeconds < shouldWaitSeconds) return true;

    lastClick.clear();
    lastClick.add(currentTime);
    return false;
  }
}
