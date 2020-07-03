class SteeringSetting {
  double min;
  double max;
  double step;
  double value;
  int steeringId;

  SteeringSetting({this.min, this.max, this.step, this.value, this.steeringId});

  SteeringSetting.fromJson(Map<String, dynamic> json)
      : min = json['min'],
        max = json['max'],
        step = json['step'],
        value = json['value'],
        steeringId = json['steeringId'];

  Map<String, dynamic> toJson() => {
        'min': min,
        'max': max,
        'step': step,
        'value': value,
        'steeringId': steeringId,
      };
}
