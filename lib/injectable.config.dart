// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:panara_studios/core/connection/network_info.dart' as _i4;
import 'package:panara_studios/features/authentication/data/datasources/google_signing_source.dart'
    as _i3;
import 'package:panara_studios/features/authentication/data/repositories/authentication_repository_impl.dart'
    as _i7;
import 'package:panara_studios/features/authentication/domain/repositories/authentication_repository.dart'
    as _i6;
import 'package:panara_studios/features/authentication/domain/usecases/google_signin.dart'
    as _i8;
import 'package:panara_studios/features/authentication/presentation/bloc/authentication_bloc.dart'
    as _i9;

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
    gh.factory<_i3.GoogleSignDataSource>(() => _i3.GoogleSignDataSourceImpl());
    gh.factory<_i4.NetworkInfo>(
        () => _i4.NetworkInfoImpl(gh<_i5.Connectivity>()));
    gh.factory<_i6.AuthenticationRepository>(
        () => _i7.AuthenticationRepositoryImpl(
              networkInfo: gh<_i4.NetworkInfo>(),
              remoteDataSource: gh<_i3.GoogleSignDataSource>(),
            ));
    gh.factory<_i8.GoogleSignin>(
        () => _i8.GoogleSignin(repository: gh<_i6.AuthenticationRepository>()));
    gh.factory<_i9.AuthenticationBloc>(
        () => _i9.AuthenticationBloc(gh<_i8.GoogleSignin>()));
    return this;
  }
}
