class StateModel {
  bool isLoading;
  bool isError;
  bool isSuccess;
  bool showProgress;
  String msg;

  StateModel({
    this.isError = false,
    this.isLoading = false,
    this.showProgress = false,
    this.isSuccess = false,
    this.msg = '',
  });
}

class Pagination {
  int limit;
  int offset;
  int page;
  bool hasMore;

  Pagination({
    this.limit = 5,
    this.offset = 0,
    this.page = 1,
    this.hasMore = true,
  });
}
