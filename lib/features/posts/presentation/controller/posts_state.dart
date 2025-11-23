part of 'posts_cubit.dart';

@immutable
class PostsState extends Equatable {
  final List<PostsModel> listOfPosts;
  final List<CommentsModel> listOfComments;
  final List<CategoryPostModel> listOfCategory;
  final PostsModel? currentPost;
  final CategoryPostModel? selectedCategoryId;
  final RequestStateEnum requestState;
  final RequestStateEnum requestStateOfAddPost;
  final RequestStateEnum requestStateOfCurrentPost;
  final PaginateModel? paginationData;
  final PaginateModel? paginationCommentsData;
  final int page;
  final int pageComments;

  PostsState(
      {required this.listOfPosts,
      required this.requestState,
      required this.requestStateOfCurrentPost,
      required this.requestStateOfAddPost,
      required this.listOfCategory,
      required this.listOfComments,
      required this.pageComments,
      this.paginationData,
      this.selectedCategoryId,
      this.paginationCommentsData,
      this.currentPost,
      required this.page});
  PostsState copyWith({
    RequestStateEnum? requestState,
    RequestStateEnum? requestStateOfCurrentPost,
    RequestStateEnum? requestStateOfAddPost,
    PaginateModel? paginationData,
    CategoryPostModel? selectedCategoryId,
    PaginateModel? paginationCommentsData,
    PostsModel? currentPost,
    int? page,
    int? pageComments,
    List<PostsModel>? listOfPosts,
    List<CategoryPostModel>? listOfCategory,
    List<CommentsModel>? listOfComments,
  }) {
    return PostsState(
      requestState: requestState ?? this.requestState,
      requestStateOfAddPost:
          requestStateOfAddPost ?? this.requestStateOfAddPost,
      listOfCategory: listOfCategory ?? this.listOfCategory,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      listOfComments: listOfComments ?? this.listOfComments,
      currentPost: currentPost ?? this.currentPost,
      page: page ?? this.page,
      paginationCommentsData:
          paginationCommentsData ?? this.paginationCommentsData,
      pageComments: pageComments ?? this.pageComments,
      requestStateOfCurrentPost:
          requestStateOfCurrentPost ?? this.requestStateOfCurrentPost,
      paginationData: paginationData ?? this.paginationData,
      listOfPosts: listOfPosts ?? this.listOfPosts,
    );
  }

  PostsState clearCurrentPost() {
    return PostsState(
      requestState: requestState,
      listOfComments: [],
      listOfCategory: listOfCategory,
      currentPost: null,
      requestStateOfAddPost: RequestStateEnum.initial,
      selectedCategoryId: null,
      paginationCommentsData: null,
      pageComments: 0,
      page: page,
      requestStateOfCurrentPost: RequestStateEnum.initial,
      paginationData: paginationData,
      listOfPosts: listOfPosts,
    );
  }

  @override
  List<Object?> get props => [
        currentPost,
        listOfCategory,
        listOfPosts,
        selectedCategoryId,
        requestStateOfAddPost,
        listOfComments,
        requestStateOfCurrentPost,
        paginationCommentsData,
        requestState,
        pageComments,
        page,
        paginationData
      ];
}
