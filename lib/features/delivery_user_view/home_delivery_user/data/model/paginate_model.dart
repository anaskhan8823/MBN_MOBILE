class PaginateModel {
  int? total;
  int? count;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;
  int? currentPage;
  int? totalPages;

  PaginateModel(
      {this.total,
      this.count,
      this.perPage,
      this.nextPageUrl,
      this.prevPageUrl,
      this.currentPage,
      this.totalPages});

  PaginateModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}
