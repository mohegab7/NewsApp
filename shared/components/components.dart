import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/moduels/news_app/web_view/web_view.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget LoginButton({
  double width = double.infinity,
  String text = 'login',
  bool isUppercase = true,
  double radius = 0.0,
  void Function()? function,
  Color? background,
  Color colortext = Colors.white,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: colortext,
          ),
        ),
      ),
    );

Widget defaultTextbutton({
  required void Function() function,
  required String text,
  Color? color,
  double? size,
  FontWeight? fontweight,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontweight,
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  required String text,
  bool isUppercase = true,
  double radius = 20.0,
  void Function()? function,
  Color? background,
  Color colortext = Colors.white,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: colortext,
          ),
        ),
      ),
    );

Widget PasswordText({
  required TextEditingController controller,
  TextInputType keyboardtype = TextInputType.visiblePassword,
  String text = 'password',
  IconData prefix = Icons.lock,
  IconData suffix = Icons.remove_red_eye,
  void Function(String)? onchanged,
  void Function(String)? onSubmit,
  bool show = false,
  void Function()? function,
}) =>
    Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
          border: Border.all(
            color: defaultColor,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: TextFormField(
          onChanged: onchanged,
          onFieldSubmitted: onSubmit,
          cursorColor: Colors.black,
          validator: (value) {
            if (value!.isEmpty) {
              return 'password must not empty';
            }
            return null;
          },
          controller: controller,
          obscureText: show,
          keyboardType: keyboardtype,
          decoration: InputDecoration(
            labelText: text,
            border: OutlineInputBorder(),
            prefixIcon: Icon(prefix),
            suffixIcon: IconButton(onPressed: function, icon: Icon(suffix)),
          ),
        ));

Widget defaultFormField({
  required controller,
  hint = '',
  required type,
  void Function(String)? onType,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? suffixPressed,
  void Function()? onTap,
  String? Function(String?)? validator,
  IconData? prefix,
  IconData? suffix,
  String? text,
  isPassword = false,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: defaultColor,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        validator: validator,
        onFieldSubmitted: onSubmit,
        controller: controller,
        onTap: onTap,
        keyboardType: type,
        obscureText: isPassword,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: hint,
          labelText: text,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ))
              : null,
          border: InputBorder.none,
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1.0,
      ),
    );
Widget buildArctricleItem(article, context) => InkWell(
      onTap: () {
        Navigateto(
          context,
          WebView_Screen(article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 130.0,
              width: 130.0,
              child: Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.q1EqsVArG9OcXqnDYwEMxwHaE6?rs=1&pid=ImgDetMain'),
                  fit: BoxFit.cover),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.brown),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArctricleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10),
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()));

void Navigateto(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void NavigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCES, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCES:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
