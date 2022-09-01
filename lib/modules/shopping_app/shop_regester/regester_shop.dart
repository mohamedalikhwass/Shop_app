import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khwass_app/modules/shopping_app/login_shop/login_screen.dart';
import 'package:khwass_app/modules/shopping_app/shop_regester/cubit_regester/cubit.dart';

import '../../../layout/shop_app/shop_layout_app.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shaerd/components/components.dart';
import '../../../shaerd/components/constantes.dart';
import '../../../styles/colors.dart';
import '../login_shop/cubit_login/states.dart';
import 'cubit_regester/states.dart';

class ShopAppRegister extends StatelessWidget {

  var nameControl =TextEditingController();
  var phoneControl =TextEditingController();
  var emailControl =TextEditingController();
  var passwordControl =TextEditingController();

  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener:(context, state) {

          if(state is ShopRegisterSuccessState)
          {
            if(state.shopRegisterModel.status) {
              print(state.shopRegisterModel.message);
              print(state.shopRegisterModel.data.token);
              Fluttertoast.showToast(
                  msg: state.shopRegisterModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.amber,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              CacheHelper.saveData(
                key: 'token',
                value:state.shopRegisterModel.data.token,
              ).then((value)
              {
                token =state.shopRegisterModel.data.token;
                navigatorToAndFinch(context,ShopLayOutApp());
              });

            }
            else
            {
              print(state.shopRegisterModel.message);
              showToast(state: StateToast.ERROR, msg: state.shopRegisterModel.message);

            }

          }

        } ,
        builder: (context,state)
        {

          var cubit = ShopRegisterCubit.get(context);
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
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text(
                          'Register',
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
                          control: nameControl,
                          icon: Icons.person_rounded,
                          textType: TextInputType.name,
                          labelText: 'Name',
                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Name must not be  Empty ';
                            }
                            return null;
                          },

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextForm(
                          control: phoneControl,
                          icon: Icons.phone,
                          textType: TextInputType.phone,
                          labelText: 'Phone Number',
                          validat:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return ' Phone Number must not be  Empty ';
                            }
                            return null;
                          },

                        ),
                        SizedBox(
                          height: 20.0,
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
                          // onFieldSubmitted: (value) {
                          //   if (formKey.currentState.validate()) {
                          //     cubit.loginUser(
                          //         email: emailControl.text,
                          //         password: passwordControl.text
                          //     );
                          //   }
                          //
                          // },

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
                          condition:state is! ShopRegisterLoadingState ,
                          builder:(context)
                          {
                            return defaultButton(
                              color: defaultColor,
                              function: (){
                                if(formKey.currentState.validate()) {
                                  cubit.registerUser(
                                      name:nameControl.text,
                                      phone:phoneControl.text,
                                      email:emailControl.text,
                                      password: passwordControl.text
                                  );
                                }


                              },
                              text: 'Register',
                              widith: double.infinity,
                              isUpperCase: true,

                            );
                          } ,
                          fallback: (context)=>CircularProgressIndicator(),
                        ),
                        Row(
                          children: [
                            Text(
                                'I\'m have account ?'
                            ),
                            TextButton(onPressed: ()
                            {
                              navigatorToAndFinch(context,ShopAppLogin());
                            },
                                child: Text('Login')),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}
