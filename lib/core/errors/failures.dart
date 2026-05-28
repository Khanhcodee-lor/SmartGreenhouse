abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure([super.message = 'Firebase error occurred']);
}
