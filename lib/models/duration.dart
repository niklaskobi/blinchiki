class MyDuration {
  int minutes;
  int seconds;

  MyDuration({this.minutes, this.seconds});

  MyDuration.fromJson(Map<String, dynamic> json)
      : minutes = json['minutes'],
        seconds = json['seconds'];

  Map<String, dynamic> toJson() => {'minutes': minutes, 'seconds': seconds};

  String toString() => '${this.minutes}:${this.seconds.toString().padLeft(2, '0')}';

  int getOverallSeconds() => this.minutes * 60 + this.seconds;
}
