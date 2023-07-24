import 'package:flutter/material.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/modules/widgets/widgets.dart';



// Widget unSelectedSignUpButton (context) {
//   return Expanded(
//     child: SizedBox(
//       height: MediaQuery.of(context).size.height * 1 / 12,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: TextButton(
//             onPressed:func,
//             child: Text(
//               AppStringsInEnglish.signup,
//               style:
//               TextStyle(color: AppColors.black, fontSize: 20),
//             )),
//       ),
//     ),
//   );
// }

Widget unSelectedLoginButton (context,func) {
  return Expanded(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 1 / 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextButton(
            onPressed: func,
            child: Text(
              AppStringsInEnglish.login,
              style:
              TextStyle(color: AppColors.black, fontSize: 20),
            )),
      ),
    ),
  );
}

// Widget selectedLoginBar(context,func){
//   return Container(
//     height: MediaQuery.of(context).size.height * 1 / 12,
//     decoration:  BoxDecoration(
//       color: Colors.white,
//       borderRadius:const BorderRadius.only(
//         topLeft: Radius.circular(23),
//         topRight: Radius.circular(23),
//         bottomRight: Radius.circular(23),
//         bottomLeft: Radius.circular(0),
//       ),
//       boxShadow: [BoxShadow(
//         color: Colors.black.withOpacity(0.5),
//         spreadRadius: 3,
//         blurRadius: 5,
//         offset:const Offset(0, 4), // changes position of shadow
//       ),],
//     ),
//     width: MediaQuery.of(context).size.width * 0.90,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         selectedLoginButton(context),
//         unSelectedSignUpButton(context, func)
//       ],
//     ),
//   );
// }

// Widget selectedSignupBar(context,func){
//   return Container(
//     height: MediaQuery.of(context).size.height * 1 / 12,
//     decoration:  BoxDecoration(
//       color: Colors.white,
//       borderRadius:const BorderRadius.only(
//         topLeft: Radius.circular(23),
//         topRight: Radius.circular(23),
//         bottomRight: Radius.circular(23),
//         bottomLeft: Radius.circular(23),
//       ),
//       boxShadow: [BoxShadow(
//         color: Colors.black.withOpacity(0.5),
//         spreadRadius: 3,
//         blurRadius: 5,
//         offset:const Offset(0, 4), // changes position of shadow
//       ),],
//     ),
//     width: MediaQuery.of(context).size.width * 0.90,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         unSelectedLoginButton(context, func),
//         selectedSignupButton(context)
//       ],
//     ),
//   );
// }
























Widget selectedLoginButton (context) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          borderRadius:const BorderRadius.only(topLeft:Radius.circular(23),bottomRight: Radius.circular(23) )
          ,color: AppColors.primary
      ),
      height: MediaQuery.of(context).size.height * 1 / 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextButton(
            onPressed: () {},
            child: Text(
              AppStringsInEnglish.login,
              style:
              TextStyle(color: AppColors.black, fontSize: 20),
            )),
      ),
    ),
  );
}
Widget selectedSignupButton (context) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          borderRadius:const BorderRadius.only(bottomLeft:Radius.circular(23),topRight: Radius.circular(23) )
          ,color: AppColors.primary
      ),
      height: MediaQuery.of(context).size.height * 1 / 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextButton(
            onPressed: () {},
            child: Text(
              AppStringsInEnglish.signup,
              style:
              TextStyle(color: AppColors.black, fontSize: 20),
            )),
      ),
    ),
  );
}

Widget loginForms({required emailController,required passwordController,required context , }){
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Column(
      children: [
        defaultTextFormField(
          arabic: false,
          validator: (value) {
            if (value.length < 5) {
              return 'email  is invalid';
            } else {
              return null;
            }
          },
          controller: emailController,
          label: AppStringsInEnglish.emailAddress,
          textInputType: TextInputType.emailAddress, isPassword: false,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*1/60,
        ),
        defaultTextFormField(
          arabic: false,
          validator: (value) {
            if (value.length < 5) {
              return 'password is invalid';
            } else {
              return null;
            }
          },
          controller: passwordController,
          label: AppStringsInEnglish.password,
          textInputType: TextInputType.visiblePassword, isPassword: true,
        )
      ],
    ),
  );
}

Widget signupForms({required usernameController ,required emailController,required passwordController,required phoneController ,required context , }){
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Column(
      children: [
        defaultTextFormField(
          arabic: false,
          validator: (value) {
            if (value.length < 5) {
              return 'username  is invalid';
            } else {
              return null;
            }
          },
          controller: usernameController,
          label: AppStringsInEnglish.username,
          textInputType: TextInputType.name, isPassword: false,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*1/60,
        ),
        defaultTextFormField(
          arabic: false,
          validator: (value) {
            if (value.length < 5) {
              return 'email  is invalid';
            } else {
              return null;
            }
          },
          controller: emailController,
          label: AppStringsInEnglish.emailAddress,
          textInputType: TextInputType.emailAddress, isPassword: false,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*1/60,
        ),
        defaultTextFormField(
          arabic: false,
          validator: (value) {
            if (value.length < 5) {
              return 'password is invalid';
            } else {
              return null;
            }
          },
          controller: passwordController,
          label: AppStringsInEnglish.password,
          textInputType: TextInputType.visiblePassword, isPassword: true,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*1/60,
        ),
        defaultTextFormField(
          arabic: false,
          validator: (value) {
            if (value.length < 10) {
              return 'phone is invalid';
            } else {
              return null;
            }
          },
          controller: phoneController,
          label: AppStringsInEnglish.phoneNumber,
          textInputType: TextInputType.phone, isPassword: false,
        )
      ],
    ),
  );
}

