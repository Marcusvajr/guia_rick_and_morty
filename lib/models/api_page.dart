class ApiPage<T> {
  const ApiPage({
    required this.items,
    required this.nextPage,
  });

  final List<T> items;
  final int? nextPage;
}
