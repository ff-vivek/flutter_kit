typedef StringValidator = String? Function(String? value);

/// Built-in validators for Uk form fields.
class UkValidators {
  static StringValidator required([String message = 'This field is required']) {
    return (value) {
      if (value == null || value.trim().isEmpty) return message;
      return null;
    };
  }

  static StringValidator email([String message = 'Please enter a valid email']) {
    final regex = RegExp(r'^\S+@\S+\.\S+$');
    return (value) {
      if (value == null || value.trim().isEmpty) return null; // use required() separately
      if (!regex.hasMatch(value.trim())) return message;
      return null;
    };
  }

  static StringValidator minLength(int n, [String? message]) {
    return (value) {
      if (value == null) return null;
      if (value.trim().length < n) return message ?? 'Minimum $n characters required';
      return null;
    };
  }

  static StringValidator maxLength(int n, [String? message]) {
    return (value) {
      if (value == null) return null;
      if (value.trim().length > n) return message ?? 'Maximum $n characters allowed';
      return null;
    };
  }

  /// Compose multiple validators: returns the first error message if any.
  static StringValidator compose(List<StringValidator> validators) {
    return (value) {
      for (final v in validators) {
        final res = v(value);
        if (res != null) return res;
      }
      return null;
    };
  }
}
