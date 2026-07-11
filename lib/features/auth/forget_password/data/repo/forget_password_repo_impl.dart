import 'package:exam_app/core/error/exceptions.dart';
import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/auth/forget_password/data/datasource/remote/forget_password_remote_datasource.dart';
import 'package:exam_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  ForgetPasswordRepoImpl(this._remoteDatasource);

  final ForgetPasswordRemoteDatasource _remoteDatasource;

  @override
  Future<({Failure? failure})> forgotPassword(String email) {
    return _execute(() => _remoteDatasource.forgotPassword(email));
  }

  @override
  Future<({Failure? failure})> verifyResetCode(String resetCode) {
    return _execute(() => _remoteDatasource.verifyResetCode(resetCode));
  }

  @override
  Future<({Failure? failure})> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return _execute(
      () => _remoteDatasource.resetPassword(
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
