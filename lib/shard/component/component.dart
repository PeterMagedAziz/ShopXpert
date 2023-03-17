import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla_app/layout/cubit/cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:salla_app/shard/network/styles/colors.dart';
import '../size_config.dart';
import 'constants.dart';
Widget myDivider() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Container(

    width: double.infinity,

    height: 1.0,

    color: Colors.grey[300],

  ),
);
Widget defaultTextFormField({
  var controller,
  var onSubmit,
  bool obscureText = false,
  TextInputType? keyboardType,
  TextInputAction? action,
  String? labelText,
  String? hintText = "",
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  var validation,
  context,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      textInputAction: action,
      style: const TextStyle(
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
        ),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 10.0),
          child: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffixIcon),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: validation,
    );


Widget defaultButton({
  Color color = kPrimaryColor,
  double width = double.infinity,
  required Function function,
  double height = 55,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: () => function(),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(28),
  borderSide: const BorderSide(color: kTextColor),
  gapPadding: 10,
);



// Widget defaultTextFormField({
//   bool showPassword = false,
//   required TextInputType type,
//   required TextEditingController controller,
//   onFieldSubmitted,
//   onChanged,
//   onTap,
//   Function? validator,
//   IconData? prefix,
//   IconData? suffix,
//   suffixPress,
//   String? hint,
// }) =>
//     Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       height: 60,
//       child: TextFormField(
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         obscureText: showPassword,
//         keyboardType: type,
//         controller: controller,
//         onTap: onTap,
//         onFieldSubmitted: onFieldSubmitted,
//         onChanged: onChanged,
//         validator: (value) => validator!(value),
//         decoration: InputDecoration(
//           border: const UnderlineInputBorder(),
//           errorStyle: const TextStyle(
//             fontSize: 12,
//             fontStyle: FontStyle.normal,
//             height: 2,
//           ),
//           hintText: hint,
//           hintStyle:
//               const TextStyle(height: 2.5, fontSize: 15, color: Colors.grey),
//           prefixIcon: Icon(
//             prefix,
//           ),
//           prefixIconConstraints:
//               const BoxConstraints(maxHeight: 15, minWidth: 50),
//           suffix: IconButton(
//             onPressed: suffixPress,
//             icon: Icon(
//               suffix,
//             ),
//           ),
//         ),
//       ),
//     );
Widget defaultTextButton({VoidCallback? function, String? text}) => TextButton(
  onPressed: function,
  child: Text("$text".toUpperCase()),
);
void navigateReplacementTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defaultElevatedButton({
  double? height = 50.0,
  double? width = double.infinity,
  VoidCallback? function,
  String? text,
  double? borderRadius = 0.0,
  Color? colorText = Colors.white,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        onPressed: function,
        child: Text(
          "$text".toUpperCase(),
          style: TextStyle(
            color: colorText,
          ),
        ),
      ),
    );

Widget defaultElevatedButtonWithIcon({
  double? height = 45.0,
  double? width = 200.0,
  VoidCallback? function,
  Color? backgroundColor = Colors.blue,
  String? text,
  double? borderRadius = 15.0,
  Color? colorText = Colors.white,
  IconData? icon,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            colorText!,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$text".toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Icon(
              icon,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
class LanguageModel {
  final String language;
  final String code;

  LanguageModel({
    required this.language,
    required this.code,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(code: 'ar', language: 'العربيه'),
  LanguageModel(code: 'en', language: 'English'),
];
Widget paymentBuilder({context,function,text,icon,value})=> Card(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: Row(
      children: [
        Text(text,),
        const Spacer(),
        Container(child: icon),
        Checkbox(
            activeColor: Colors.green,
            value: value, onChanged: function),
      ],
    ),
  ),
);


void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });
void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}
Widget buildListProduct(
    model,
    context,
     {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: "${model.image}",
                    placeholder: (context, url) => const SizedBox(
                      height: 100.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    height: 120.0,
                    width: 120,
                  ),
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100.0),
                      ),
                    ),
                    child: const Text(
                      "Discount",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "${model.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.3,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${model.price}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "${model.oldPrice}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      const Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     ShopAppCubit.get(context).changeFavorites(model.id);
                      //   },
                      //   // icon: CircleAvatar(
                      //   //   radius: 15.0,
                      //   //   backgroundColor:
                      //   //   ShopAppCubit.get(context).favorites[model.id]!
                      //   //       ? defaultColor
                      //   //       : Colors.grey,
                      //   //   child: const Icon(
                      //   //     Icons.favorite_border,
                      //   //     size: 20.0,
                      //   //     color: Colors.white,
                      //   //   ),
                      //   // ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}

Widget separated() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 0.6,
        width: double.infinity,
        color: Colors.blueGrey,
      ),
    );
SizedBox appBarLeading(BuildContext context, {num height = 18}) {
  return SizedBox(
    height: getProportionateScreenWidth(40),
    width: getProportionateScreenWidth(40),
    child: TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: () => Navigator.pop(context),
      child: SvgPicture.asset("assets/icons/Back ICon.svg",
          height: height.toDouble(), color: kSecondaryColor),
    ),
  );
}
