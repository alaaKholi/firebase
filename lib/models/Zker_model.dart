class Zker {
  Zker({
    required this.id,
    required this.title,
    required this.description,
    required this.counter,
    required this.targetCount,
    required this.isDone,
  });

  String id;
  String title;
  String description;
  int counter;
  int targetCount;
  bool isDone;

  factory Zker.fromJson(Map<String, dynamic> json,String id) => Zker(
        id: id,
        title: json["title"],
        description: json["description"],
        counter: json["counter"],
        targetCount: json["targetCount"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "isDone": isDone,
        "targetCount": targetCount,
        "counter": counter,
        "description": description,
        "title": title,
      };
      
}
