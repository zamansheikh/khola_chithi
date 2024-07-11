// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khola_chithi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:khola_chithi/features/auth/domain/repositories/auth_repository.dart';
import 'package:khola_chithi/features/auth/domain/usecases/check_auth_status.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_in.dart';
import 'package:khola_chithi/features/auth/domain/usecases/sign_out.dart';
import 'package:khola_chithi/features/auth/presentation/providers/app_auth_provider.dart';
import 'package:khola_chithi/features/post/data/repositories/post_repository_impl.dart';
import 'package:khola_chithi/features/post/domain/repositories/post_repository.dart';
import 'package:khola_chithi/features/post/domain/usecases/add_post.dart';
import 'package:khola_chithi/features/post/domain/usecases/get_posts.dart';
import 'package:khola_chithi/features/post/domain/usecases/edit_post.dart';
import 'package:khola_chithi/features/post/domain/usecases/delete_post.dart';
import 'package:khola_chithi/features/post/domain/usecases/react_to_post.dart';
import 'package:khola_chithi/features/post/presentation/providers/post_provider.dart';

final sl = GetIt.instance;

void init() {
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Auth Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  // Post Repositories
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(firestore: sl()));

  // Auth Use cases
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));

  // Post Use cases
  sl.registerLazySingleton(() => AddPost(sl()));
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => EditPost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));
  sl.registerLazySingleton(() => ReactToPost(sl()));

  // Providers
  sl.registerFactory(() => AppAuthProvider(
        signInUseCase: sl(),
        signOutUseCase: sl(),
        checkAuthStatusUseCase: sl(),
      ));
  sl.registerFactory(() => PostProvider(
        addPostUseCase: sl(),
        getPostsUseCase: sl(),
        editPostUseCase: sl(),
        deletePostUseCase: sl(),
        reactToPostUseCase: sl(),
      ));
}
