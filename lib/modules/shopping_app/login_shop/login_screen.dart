import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khwass_app/layout/shop_app/shop_layout_app.dart';
import 'package:khwass_app/models/shop_model/shop_login_model.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/cubit_login/cubit.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/cubit_login/states.dart';
import 'package:khwass_app/network/local/cache_helper.dart';
import 'package:khwass_app/shaerd/components/components.dart';
import 'package:khwass_app/shaerd/components/constantes.dart';
import 'package:khwass_app/styles/colors.dart';

import '../shop_regester/regester_shop.dart';

class ShopAppLogin extends StatelessWidget {



  var emailControl =TextEditingController();

  var passwordControl =TextEditingController();

  var formKey= GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    ShopLoginModel loginModel;
    return BlocProvider(
      create: (BuildContext context)=>ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
            {
              if(state.shopLoginModel.status) {
                print(state.shopLoginModel.message);
                print(state.shopLoginModel.data.token);
                Fluttertoast.showToast(
                    msg: state.shopLoginModel.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.amber,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                CacheHelper.saveData(
                    key: 'token',
                    value:state.shopLoginModel.data.token,
                ).then((value)
                {
                  token =state.shopLoginModel.data.token;
                  navigatorToAndFinch(context,ShopLayOutApp());
                });

              }
              else
                {
                  print(state.shopLoginModel.message);
                  showToast(state: StateToast.ERROR, msg: state.shopLoginModel.message);

                }

            }
        },
        builder: (context,state)
        {
         ShopAppCubit cubit =ShopAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: (
                    Text(
                      'Khwass',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 28,

                      ),
                    )
                ),
              ),
              
              actions: [
                TextButton(
                  onPressed:()
                  {
                    navigatorTo(context,ShopLayOutApp());
                  } ,
                  child:Text('SKIP') ,

                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child:Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: defaultColor,

                          ),
                        ),
                        SizedBox(
                          height:40.0,
                        ),
                        defaultTextForm(
                          control: emailControl,
                          icon: Icons.email,
                          textType: TextInputType.emailAddress,
                          labelText: 'Email',
                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Email must not be  Empty ';
                            }
                            return null;
                          },

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState.validate()) {
                              cubit.loginUser(
                                  email: emailControl.text,
                                  password: passwordControl.text
                              );
                            }
                            
                          },

                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Password must not short ';
                            }
                            return null;
                          },
                          suffixicon: cubit.iconShowPassword,

                          onPreased: ()
                          {
                            cubit.changePasswordIcon();
                          },
                          labelText: 'Password',
                          textType:TextInputType.visiblePassword,
                          icon: Icons.lock,
                          control: passwordControl,
                          obscure: cubit.isPassword,


                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! ShopLoginLoadingState ,
                          builder:(context)
                          {
                            return defaultButton(
                              color: defaultColor,
                              function: (){
                                if(formKey.currentState.validate()) {
                                  cubit.loginUser(
                                      email:emailControl.text,
                                      password: passwordControl.text
                                  );
                                }


                              },
                              text: 'login',
                              widith: double.infinity,
                              isUpperCase: true,

                            );
                          } ,
                          fallback: (context)=>CircularProgressIndicator(),
                        ),
                        Row(
                          children: [
                            Text(
                                'Don\'n have account ?'
                            ),
                            TextButton(onPressed: ()
                            {
                              navigatorToAndFinch(context,ShopAppRegister());
                            },
                                child: Text('Register')),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

