import 'dart:io';

import 'package:dalil_2020_app/core/errors/failure.dart';
import 'package:dalil_2020_app/features/posts/data/model/comments_model.dart';

import 'package:dalil_2020_app/features/posts/data/model/posts_model.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/dio_helper.dart';
import '../../../../core/end_points.dart';
import '../../../../core/helper/app_toast.dart';
import 'posts_repo.dart';

class PostsRepoImpel implements PostsRepo {
  @override
  Future<Either<Failure, PostsWithPagination>> getDataOfAllPosts(
      int page, String? search, int? categoryId) async {
    try {
      final response = await DioHelper.get(SOCIAL_NETWORK_POSTS, parameter: {
        'page': page,
        if (search != null) 'search': search,
        if (categoryId != null) 'category_id': categoryId,
      });
      if (response.isSuccess) {
        return right(PostsWithPagination.fromJson(response.data['data']));
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, PostsModel>> getCurrentPost(int postId) async {
    try {
      final response = await DioHelper.get(
        "$SOCIAL_NETWORK_POSTS/$postId",
      );
      if (response.isSuccess) {
        return right(PostsModel.fromJson(response.data['data']));
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, CommentsWithPagination>> getCommentOfPost(
      {required int page, required int postId}) async {
    try {
      final response = await DioHelper.get(POST_COMMENTS(postId), parameter: {
        'page': page,
      });
      if (response.isSuccess) {
        return right(CommentsWithPagination.fromJson(response.data['data']));
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> sendComment(int postId, String comment) async {
    try {
      final response = await DioHelper.send(POST_COMMENTS(postId), data: {
        'content': comment,
      });
      if (response.isSuccess) {
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, List<CategoryPostModel>>> getCategories() async {
    try {
      final response =
          await DioHelper.get(SOCIAL_NETWORK_CATEGORIES, parameter: {});
      if (response.isSuccess) {
        final List<CategoryPostModel> categories = List<CategoryPostModel>.from(
            (response.data?['data']['items'] ?? [])
                .map((e) => CategoryPostModel.fromJson(e)));
        return right(categories);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> createPost(
      {required File? images,
      String? text,
      CategoryPostModel? category}) async {
    try {
      print('images?.path:${images?.path}');
      MultipartFile multiImages =
          MultipartFile.fromFileSync(images?.path ?? '');
      final response = await DioHelper.send(SOCIAL_NETWORK_POSTS, data: {
        "content": text,
        "category_id": category?.id,
        "image": multiImages,
      });
      if (response.isSuccess) {
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> sendLike(int postId) async {
    try {
      print('postId:$postId');
      final response = await DioHelper.send(
        POST_LIKED(postId),
      );
      if (response.isSuccess) {
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteComment(int postId) async {
    try {
      final response =
          await DioHelper.delete("$SOCIAL_NETWORK_COMMENTS/$postId");
      if (response.isSuccess) {
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> editComment(int postId, String comment) async {
    try {
      final response = await DioHelper.put("$SOCIAL_NETWORK_COMMENTS/$postId",
          data: {'content': comment});
      if (response.isSuccess) {
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }
}
