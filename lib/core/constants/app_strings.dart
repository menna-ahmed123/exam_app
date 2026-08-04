/// All UI strings extracted from Login / Sign up / Forgot password / Reset password screens
class AppStrings {
  AppStrings._();

  // ===== Login =====
  static const String login = 'Login';
  static const String email = 'Email';
  static const String enterYourEmail = 'Enter you email';
  static const String password = 'Password';
  static const String enterYourPassword = 'Enter you password';
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String signUp = 'Sign up';
  static const String emailNotValid = 'This Email is not valid';

  // ===== Sign up =====
  static const String signUpTitle = 'Sign up';
  static const String userName = 'User name';
  static const String enterYourUserName = 'Enter you user name';
  static const String firstName = 'First name';
  static const String enterFirstName = 'Enter first name';
  static const String lastName = 'Last name';
  static const String enterLastName = 'Enter last name';
  static const String enterPassword = 'Enter password';
  static const String confirmPassword = 'Confirm password';
  static const String phoneNumber = 'Phone number';
  static const String enterPhoneNumber = 'Enter phone number';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String userNameNotValid = 'This user name is not valid';
  static const String passwordNotMatched = 'Password not matched';

  // ===== Forgot password =====
  static const String passwordFlowHeader = 'Password';
  static const String forgotPasswordTitle = 'Forgot password';
  static const String forgotPasswordSubtitle =
      'Please enter your email associated to your account';
  static const String continueText = 'Continue';

  // ===== Verification code =====
  static const String emailVerification = 'Email verification';
  static const String emailVerificationSubtitle =
      'Please enter your code that send to your email address';
  static const String didntReceiveCode = "Didn't receive code?";
  static const String resend = 'Resend';
  static const String invalidCode = 'Invalid code';

  // ===== Reset password =====
  static const String resetPassword = 'Reset password';
  static const String resetPasswordHint =
      'Password must not be empty and must contain 6 characters with upper case letter and one number at least';
  static const String newPassword = 'New password';
  static const String passwordResetSuccess =
      'Password reset successfully. Please login.';

  // ===== Home =====
  static const String home = 'Home';
  static const String logout = 'Logout';

  // ===== Explore =====
  static const String survey = 'Survey';
  static const String search = 'Search';
  static const String browseBySubject = 'Browse by subject';
  static const String explore = 'Explore';
  static const String result = 'Result';
  static const String profile = 'Profile';
  static const String noSubjectsFound = 'No subjects found';
  static const String noExamsFound = 'No exams found';

  // ===== Exam instructions =====
  static const String instructions = 'Instructions';
  static const String start = 'Start';
  static const String minutes = 'Minutes';
  static const String question = 'Question';
  static const String instructionStableInternet =
      'Ensure you have a stable internet connection.';
  static const String instructionDontLeave =
      "Don't leave the screen until you finish the exam.";
  static const String instructionTimer =
      'The timer starts once you tap Start.';
  static const String instructionSubmit =
      'Submit your answers before time runs out.';

  // ===== Taking exam =====
  static const String exam = 'Exam';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String finish = 'Finish';
  static const String questionOf = 'Question';
  static const String of = 'of';
  static const String timeOutTitle = 'Time out !!';
  static const String viewScore = 'View score';
  static const String answerAtLeastOne = 'Please answer at least one question.';
  static const String noQuestionsFound = 'No questions found';
  static const String exitExamTitle = 'Exit exam?';
  static const String exitExamMessage =
      'Your progress will be lost if you leave now.';
  static const String exit = 'Exit';
  static const String cancel = 'Cancel';

  // ===== Score =====
  static const String examScore = 'Exam score';
  static const String yourScore = 'Your score';
  static const String correct = 'Correct';
  static const String incorrect = 'Incorrect';
  static const String showResults = 'Show results';
  static const String startAgain = 'Start again';

  // ===== Results / Answers =====
  static const String results = 'Results';
  static const String answers = 'Answers';
  static const String noExamHistory = 'No exam history yet';
  static const String correctedAnswersIn = 'corrected answers in';
  static const String min = 'min';
}
