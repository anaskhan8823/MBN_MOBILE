import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../model/comments_model.dart';
import '../model/posts_model.dart';

abstract class PostsRepo {
  Future<Either<Failure, PostsWithPagination>> getDataOfAllPosts(
      int page, String? search, int? categoryId);
  Future<Either<Failure, CommentsWithPagination>> getCommentOfPost(
      {required int page, required int postId});
  Future<Either<Failure, PostsModel>> getCurrentPost(int postId);
  Future<Either<Failure, bool>> sendComment(int postId, String comment);
  Future<Either<Failure, bool>> deleteComment(int postId);
  Future<Either<Failure, bool>> editComment(int postId, String comment);
  Future<Either<Failure, bool>> sendLike(int postId);
  Future<Either<Failure, List<CategoryPostModel>>> getCategories();
  Future<Either<Failure, bool>> createPost(
      {required File? images, String? text, CategoryPostModel? category});
}
