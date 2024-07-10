class Validation {
  static String? validateCustomerName(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 10) {
      return 'Minimum Character Limit not met, please contact Admin';
    }
    if (value.length > 100) {
      return 'Maximum Character Limit Exceeded, please recheck or contact Admin';
    }
    return null;
  }

  static String? validateRoleName(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 2) {
      return 'Minimum Character Limit not met, please contact Admin';
    }
    if (value.length > 100) {
      return 'Maximum Character Limit Exceeded, please recheck or contact Admin';
    }
    return null;
  }

  static String? validateAssignProjectArchitect(String value) {
    if (value.isEmpty) {
      return 'Please select a project architect';
    }
    return null;
  }

  static String? validateUploadLogo(String value) {
    if (value.isEmpty) {
      return 'Please upload logo to proceed';
    }
    return null;
  }

  static String? validateCreateUserName(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 2) {
      return 'Minimum Character Limit not met, please contact Admin';
    }
    if (value.length > 32) {
      return 'Maximum Character Limit Exceeded, please recheck or contact Admin';
    }
    return null;
  }

  static String? validateTypeOfUser(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  static String? validateUserPhoneNumber(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length != 10) {
      return 'Please enter correct number';
    }
    return null;
  }

  static String? validateUserEmailID(String value) {
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (value.length < 8) {
      return 'Minimum Character Limit not met, please contact Admin';
    }
    if (value.length > 100) {
      return 'Maximum Character Limit Exceeded, please recheck or contact Admin';
    }
    return null;
  }

  static String? validateUserProfilePhoto(String value) {
    if (value.isEmpty) {
      return 'Please upload jpeg only';
    }
    return null;
  }
}
 