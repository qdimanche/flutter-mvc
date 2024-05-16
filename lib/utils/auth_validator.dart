String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer votre nom';
  }
  return '';
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer un email';
  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return 'Veuillez entrer un email valide';
  }
  return '';
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Veuillez entrer un mot de passe';
  } else if (value.length < 12) {
    return 'Le mot de passe doit contenir au moins 12 caractères';
  } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
    return 'Le mot de passe doit contenir au moins une minuscule';
  } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
    return 'Le mot de passe doit contenir au moins une majuscule';
  } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
    return 'Le mot de passe doit contenir au moins un chiffre';
  }
  return '';
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'Veuillez confirmer votre mot de passe';
  } else if (value != password) {
    return 'Les mots de passe ne correspondent pas';
  }
  return '';
}
