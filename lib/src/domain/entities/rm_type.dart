
enum RmType {

  frontSquat('Front Squat'),
  backSquat('Back Squat'),
  overheadSquat('Overhead Squat'),
  benchPress('Bench Press'),
  shoulderPress('Shoulder Press'),
  pushPress('Push Press'),
  jerk('Jerk'),
  snatch('Snatch'),
  clean('Clean'),
  deadlift('Deadlift');

  const RmType(this.text);

  final String text;
}