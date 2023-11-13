class PaginationModel<T> {
  List<T> data = [];
  final int total;

  PaginationModel({required this.data, required this.total});
}
