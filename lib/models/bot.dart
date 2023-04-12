class Bot{

  final String name;
  final String description;
  DateTime lastCleaned;
  bool isCleaning;
  bool isActive;

  Bot({this.name, this.description, this.lastCleaned,this.isCleaning, this.isActive});
}