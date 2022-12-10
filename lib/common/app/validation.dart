class Validation{
  static String? fieldEmptyValidation(value){
    if(value.isEmpty){
      return 'Please enter value';
    }else{
      return null;
    }
  }
}