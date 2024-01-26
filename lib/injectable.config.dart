// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i8;
import 'package:file_picker/file_picker.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:panara_studios/core/connection/network_info.dart' as _i7;
import 'package:panara_studios/core/functions/local_file_access.dart' as _i5;
import 'package:panara_studios/features/authentication/data/datasources/google_signing_source.dart'
    as _i4;
import 'package:panara_studios/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i10;
import 'package:panara_studios/features/authentication/domain/repositories/authentication_repository.dart'
    as _i9;
import 'package:panara_studios/features/authentication/domain/usecases/google_signin.dart'
    as _i14;
import 'package:panara_studios/features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i16;
import 'package:panara_studios/features/feeds/data/datasources/feed_data_sources.dart'
    as _i3;
import 'package:panara_studios/features/feeds/data/repositories/feed_repository_impl.dart'
    as _i12;
import 'package:panara_studios/features/feeds/domain/repositories/feed_repository.dart'
    as _i11;
import 'package:panara_studios/features/feeds/domain/usecases/add_post.dart'
    as _i15;
import 'package:panara_studios/features/feeds/domain/usecases/fetch_posts.dart'
    as _i13;
import 'package:panara_studios/features/feeds/presentation/bloc/feeds_bloc.dart'
    as _i17;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.FeedDataSources>(() => _i3.FeedDataSourcesImpl());
    gh.factory<_i4.GoogleSignDataSource>(() => _i4.GoogleSignDataSourceImpl());
    gh.factory<_i5.LocalFileAccess>(
        () => _i5.LocalFileAccessImpl(picker: gh<_i6.FilePicker>()));
    gh.factory<_i7.NetworkInfo>(
        () => _i7.NetworkInfoImpl(gh<_i8.Connectivity>()));
    gh.factory<_i9.AuthenticationRepository>(
        () => _i10.AuthenticationRepositoryImpl(
              networkInfo: gh<_i7.NetworkInfo>(),
              remoteDataSource: gh<_i4.GoogleSignDataSource>(),
            ));
    gh.factory<_i11.FeedRepository>(() => _i12.FeedRepositoryImpl(
          dataSources: gh<_i3.FeedDataSources>(),
          networkInfo: gh<_i7.NetworkInfo>(),
        ));
    gh.factory<_i13.FetchPosts>(
        () => _i13.FetchPosts(repository: gh<_i11.FeedRepository>()));
    gh.factory<_i14.GoogleSignin>(() =>
        _i14.GoogleSignin(repository: gh<_i9.AuthenticationRepository>()));
    gh.factory<_i15.AddPost>(
        () => _i15.AddPost(repository: gh<_i11.FeedRepository>()));
    gh.factory<_i16.AuthenticationBloc>(
        () => _i16.AuthenticationBloc(gh<_i14.GoogleSignin>()));
    gh.factory<_i17.FeedsBloc>(() => _i17.FeedsBloc(
          gh<_i15.AddPost>(),
          gh<_i13.FetchPosts>(),
        ));
    return this;
  }
}
