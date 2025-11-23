import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quiver/strings.dart';

import '../../../../core/helper/app_navigator.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../delivery_user_view/home_delivery_user/data/model/paginate_model.dart';
import '../../data/model/comments_model.dart';
import '../../data/model/posts_model.dart';
import '../../data/repo/posts_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo postsRepo;
  PostsCubit({required this.postsRepo})
      : super(PostsState(
            listOfPosts: [],
            page: 0,
            requestState: RequestStateEnum.initial,
            requestStateOfAddPost: RequestStateEnum.initial,
            requestStateOfCurrentPost: RequestStateEnum.initial,
            listOfComments: [],
            pageComments: 0,
            listOfCategory: []));

  _loadingOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.loading));
  }

  _doneOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.error));
  }

  _updatePageNumber() {
    int page = state.page;
    page++;
    emit(state.copyWith(page: page));
  }

  _updatePageNumberOfComments() {
    int page = state.pageComments;
    page++;
    emit(state.copyWith(pageComments: page));
  }

  Future<void> getPosts(int? page, String? search, int? categoryId) async {
    if (page != null) {
      emit(state.copyWith(page: 0, listOfPosts: []));
    }
    if (state.page > (state.paginationData?.totalPages ?? 0)) {
      return;
    }
    _loadingOrders();

    _updatePageNumber();
    final api =
        await postsRepo.getDataOfAllPosts(state.page, search, categoryId);
    api.fold(
      (failure) {
        _errorOrders();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        _doneOrders();
        emit(state.copyWith(
            listOfPosts: state.listOfPosts..addAll(r.items ?? []),
            paginationData: r.paginate));
      },
    );
  }

  Future<void> getCommentsPost(int? page) async {
    if (page != null) {
      emit(state.copyWith(pageComments: 0, listOfComments: []));
    }
    if (state.pageComments > (state.paginationCommentsData?.totalPages ?? 0)) {
      return;
    }

    _updatePageNumberOfComments();
    final api = await postsRepo.getCommentOfPost(
        page: state.pageComments, postId: state.currentPost?.id ?? 0);
    api.fold(
      (failure) {
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        emit(state.copyWith(
            listOfComments: state.listOfComments..addAll(r.items ?? []),
            paginationCommentsData: r.paginate));
      },
    );
  }

  Future<void> _getCurrentPost(int postId) async {
    emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.loading));

    final api = await postsRepo.getCurrentPost(postId);
    api.fold(
      (failure) {
        emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.error));

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.done));
        emit(state.copyWith(currentPost: r));
      },
    );
  }

  getCurrentPostDetails({required PostsModel postData, int? page}) {
    emit(state.copyWith(currentPost: postData));
    _getCurrentPost(postData.id ?? 0);
    getCommentsPost(page);
  }

  cleanCurrentPost() {
    emit(state.clearCurrentPost());
  }

  Future<void> sendComment({required String message}) async {
    if (isBlank(message)) return;
    final api =
        await postsRepo.sendComment(state.currentPost?.id ?? 0, message);
    api.fold(
      (failure) {
        emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.error));

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        _getCurrentPost(state.currentPost?.id ?? 0);

        getCommentsPost(0);
      },
    );
  }

  Future<void> updateComment(
      {required String message, required int commentId}) async {
    if (isBlank(message)) return;
    final api = await postsRepo.editComment(commentId, message);
    api.fold(
      (failure) {
        emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.error));

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        AppNavigator.pop();

        getCommentsPost(0);
      },
    );
  }

  Future<void> deleteComment({required int commentId}) async {
    final api = await postsRepo.deleteComment(commentId);
    api.fold(
      (failure) {
        emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.error));

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        _getCurrentPost(state.currentPost?.id ?? 0);

        getCommentsPost(0);
      },
    );
  }

  Future<void> getCategory() async {
    final api = await postsRepo.getCategories();
    api.fold(
      (failure) {
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        emit(state.copyWith(listOfCategory: r));
      },
    );
  }

  submitSelectedCategory(CategoryPostModel? category) {
    emit(state.copyWith(selectedCategoryId: category));
  }

  Future<void> createPost(File? imagesList, String? text) async {
    emit(state.copyWith(requestStateOfAddPost: RequestStateEnum.loading));
    final api = await postsRepo.createPost(
        images: imagesList, text: text, category: state.selectedCategoryId);
    api.fold(
      (failure) {
        emit(state.copyWith(requestStateOfAddPost: RequestStateEnum.error));

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) async {
        await getPosts(0, null, null);
        emit(state.copyWith(requestStateOfAddPost: RequestStateEnum.done));

        AppNavigator.pop();
      },
    );
  }

  sendLikeCubit({required int postId}) async {
    final api = await postsRepo.sendLike(postId);
    api.fold(
      (failure) {
        emit(state.copyWith(requestStateOfCurrentPost: RequestStateEnum.error));

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        List<PostsModel> mainPosts = state.listOfPosts;
        List<PostsModel>? posts =
            state.listOfPosts.where((ele) => ele.id == postId).toList();
        if (posts != null && posts.isNotEmpty) {
          if (posts[0].isLiked == true) {
            posts[0].isLiked = false;
            posts[0].likesCount = (posts[0].likesCount ?? 0) - 1;
          } else {
            posts[0].isLiked = true;
            posts[0].likesCount = (posts[0].likesCount ?? 0) + 1;
          }
          mainPosts[mainPosts.indexWhere((element) => element.id == postId)] =
              posts[0];
          emit(state.copyWith(listOfPosts: []));
          emit(state.copyWith(listOfPosts: mainPosts));
        }
        if (state.currentPost != null) {
          PostsModel? currentPost = state.currentPost;

          if (currentPost?.isLiked == true) {
            currentPost?.isLiked = false;
            currentPost?.likesCount = (currentPost.likesCount ?? 0) - 1;
          } else {
            currentPost?.isLiked = true;
            currentPost?.likesCount = (currentPost.likesCount ?? 0) + 1;
          }
          emit(state.copyWith(currentPost: currentPost));
        }
      },
    );
  }
}
