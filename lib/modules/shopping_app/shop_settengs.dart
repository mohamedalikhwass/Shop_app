

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_cubit.dart';
import 'package:khwass_app/layout/shop_app/cubit_shop/shop_status.dart';
import 'package:khwass_app/layout/shop_app/shop_layout_app.dart';

import '../../shaerd/components/components.dart';
import '../../shaerd/components/constantes.dart';

class ShopSettingsScreen extends StatelessWidget {

   var nameController =TextEditingController();
   var emailController =TextEditingController();
   var phoneController =TextEditingController();
   var formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStatus>(
      listener:(context, state) {

      } ,
      builder:(context,state)
      {
        var cubit=ShopCubit.get(context);
        nameController.text =cubit.profileModel.data.name;
        emailController.text =cubit.profileModel.data.email;
        phoneController.text =cubit.profileModel.data.phone;
        return ConditionalBuilder(
          condition: cubit.profileModel !=null,
          builder: ( context)
          {
            return SingleChildScrollView(

              child: Container(
                height: 500,
                padding: EdgeInsets.all(20.0),
                color: Colors.grey.withOpacity(0.1),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultTextForm(
                        labelText: 'Name',
                        validat: (String value)
                        {
                          if(value.isEmpty  )
                          {
                            return 'name must be not Empty';
                          }
                          return null;
                        },
                        control: nameController,
                        icon: Icons.perm_identity,
                      ),
                      SizedBox(height: 15,),
                      defaultTextForm(
                        labelText: 'Email',
                        validat: (String value)
                        {
                          if(value.isEmpty  )
                          {
                            return 'name must be not Empty';
                          }
                          return null;
                        },
                        control: emailController,
                        icon: Icons.email,
                      ),
                      SizedBox(height: 15,),
                      defaultTextForm(
                        labelText: 'phone',
                        validat: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'name must be not Empty';
                          }
                          return null;
                        },
                        control: phoneController,
                        icon: Icons.phone,
                      ),
                      SizedBox(height: 20,),
                      if(state is ShopLoadingUpdateProfile)
                      LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      defaultButton(
                        widith:double.infinity ,
                        color:Colors.amber ,
                        text: 'Update',
                        function:()
                        {
                          if(formKey.currentState.validate())
                          {
                            cubit.updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        } ,
                      ),
                      SizedBox(height: 40,),

                      defaultButton(
                        widith:double.infinity ,
                        color:Colors.amber ,
                        text: 'Log Out',
                        function:()
                        {
                          logOut(context);
                        } ,
                      )

                    ],
                  ),
                ),
              ),
            );
          },
          fallback:(context)=> Center(child: CircularProgressIndicator()),

        );
      },
    );
  }



  Widget buildProfile(context)
  {
    var cubit=ShopCubit.get(context);
    return  Container(
      height: 500,
      padding: EdgeInsets.all(20.0),
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        children: [
          defaultTextForm(
            labelText: 'Name',
            validat: (String value)
            {
              if(value.isEmpty  )
              {
                return 'name must be not Empty';
              }
              return null;
            },
            control: nameController,
            icon: Icons.perm_identity,
          ),
          SizedBox(height: 15,),
          defaultTextForm(
            labelText: 'Email',
            validat: (String value)
            {
              if(value.isEmpty  )
              {
                return 'name must be not Empty';
              }
              return null;
            },
            control: emailController,
            icon: Icons.email,
          ),
          SizedBox(height: 15,),
          defaultTextForm(
            labelText: 'phone',
            validat: (String value)
            {
              if(value.isEmpty)
              {
                return 'name must be not Empty';
              }
              return null;
            },
            control: phoneController,
            icon: Icons.phone,
          ),
          SizedBox(height: 20,),
          defaultButton(
            widith:double.infinity ,
            color:Colors.amber ,
            text: 'Update',
            function:()
            {
              if(formKey.currentState.validate())
                {
                  cubit.updateProfile(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                  );
                  navigatorToAndFinch(
                      context,
                      ShopLayOutApp(),
                  );
                }
            } ,
          ),
        Spacer(),

          defaultButton(
            widith:double.infinity ,
            color:Colors.amber ,
            text: 'Log Out',
            function:()
            {
             logOut(context);
            } ,
          )

        ],
      ),
    );
  }
}
