enum AlertBoxEnum {
  confirm,
  loading,
  completed
}

class AlertBoxStatus {
  static final AlertBoxContent confirm = new AlertBoxContent(
      "Confirm",
      "Would you like to confirm all the information entered?"
  );
  static final AlertBoxContent loading = new AlertBoxContent(
      "Loading",
      "Please wait while we are converting the data into a PDF"
  );
  static final AlertBoxContent completed = new AlertBoxContent(
      "Completed",
      "Your document have been successfully processed."
  );

  static void changeStatus(String title,String description,AlertBoxEnum alertBoxEnum) {
    switch(alertBoxEnum){
      case AlertBoxEnum.confirm:
        title = AlertBoxStatus.confirm.title;
        description = AlertBoxStatus.confirm.description;
        break;
      case AlertBoxEnum.loading:
        print("test");
        title = AlertBoxStatus.loading.title;
        description = AlertBoxStatus.loading.description;
        break;
      case AlertBoxEnum.completed:
        title = AlertBoxStatus.loading.title;
        description = AlertBoxStatus.loading.description;
        break;
    }
  }

}

class AlertBoxContent {
  final String title;
  final String description;

  AlertBoxContent(this.title, this.description);
}
