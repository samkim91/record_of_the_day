
const targetRate = [0.95, 0.9, 0.85, 0.8, 0.75, 0.7, 0.65, 0.6, 0.55, 0.5];

List<double> calculatePercent(double baseValue) {
  return targetRate.map((e) => e * baseValue).toList();
}