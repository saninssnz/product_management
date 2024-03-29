import 'package:flutter/cupertino.dart';
import 'package:machine_test/src/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceFile{

  Future setLoginData(UserModel userModel) async{
    String userModelJson = userModelToJson(userModel);

    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setString("userModel", userModelJson);
  }


  Future<UserModel> getLoginData()async{
    UserModel userModel =  UserModel();
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String jsonData =null!=preferences.getString("userModel")?preferences.getString("userModel")!:"";
    if(jsonData.isNotEmpty){
      userModel =userModelFromJson(jsonData);
    }
    return userModel;
  }

}