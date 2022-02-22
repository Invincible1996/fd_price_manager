import 'package:fd_price_manager/m_colors.dart';
import 'package:fd_price_manager/pages/index_page.dart';
import 'package:fd_price_manager/view_model/product_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductListModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MColors.primaryColor,
          textTheme: GoogleFonts.notoSansAdlamTextTheme(
            Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
        ),
        builder: EasyLoading.init(),
        home: const IndexPage(),
      ),
    );
  }
}
