abstract class BaseNavigator {
  void ShowProgressDialog(String ProgressMessage, {bool isDismisble = false});
  void ShowMessage(
    String title, {
    String? posaction,
    String? negaction,
    bool isDismisible = false,
  });
  void HideDialog();
}
