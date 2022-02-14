///
/// @date: 2022/2/14 14:39
/// @author: kevin
/// @description: dart
import 'package:fd_price_manager/m_colors.dart';
import 'package:fd_price_manager/model/product_model.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List header;
  final List<ProductModel> data;

  const CustomTable({Key? key, required this.header, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: MColors.tableHeaderBgcolor,
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: MColors.divideColor,
                    ),
                  ),
                ),
                children: header
                    .map((e) => Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border(
                                // right: BorderSide(
                                //   width: 1,
                                //   color: MColors.divideColor,
                                // ),
                                ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$e',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                children: data
                    .map(
                      (e) => TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: MColors.divideColor,
                            ),
                          ),
                        ),
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text('${e.name}'),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text('${e.color}'),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text('${e.price}'),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text('data'),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: MColors.divideColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios_rounded),
                ),
                Text('1'),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
