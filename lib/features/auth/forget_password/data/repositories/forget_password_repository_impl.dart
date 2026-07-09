import 'package:exam_app/core/error/exceptions.dart';
import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/auth/forget_password/data/datasources/forget_password_remote_data_source.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  ForgetPasswordRepositoryImpl(this._remoteDataSource);

  final ForgetPasswordRemoteDataSource _remoteDataSource;

  @override
  Future<({Failure? failure})> forgotPassword(String email) {
    return _execute(() => _remoteDataSource.forgotPassword(email));
  }

  @override
  Future<({Failure? failure})> verifyResetCode(String resetCode) {
    return _execute(() => _remoteDataSource.verifyResetCode(resetCode));
  }

  @override
  Future<({Failure? failure})> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return _execute(
      () => _remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
      ),
    );
  }

  Future<({Failure? failure})> _execute(Future<void> Function() action) async {
    try {
      await action();
      return (failure: null);
    } on NetworkException catch (error) {
      return (failure: NetworkFailure(error.message));
    } on ServerException catch (error) {
      return (failure: ServerFailure(error.message));
    } catch (_) {
      return (
        failure: const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }
}
