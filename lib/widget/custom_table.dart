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
  final int totalCount;
  final int pageSize;

  const CustomTable({
    Key? key,
    required this.header,
    required this.data,
    required this.totalCount,
    required this.pageSize,
  }) : super(key: key);

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
                          decoration: BoxDecoration(),
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
            padding: EdgeInsets.symmetric(horizontal: 15),
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
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MColors.divideColor),
                    ),
                    child: Icon(Icons.keyboard_arrow_left_rounded, size: 22),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                _buildPageIndex(),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MColors.divideColor),
                    ),
                    child: Icon(Icons.keyboard_arrow_right_rounded, size: 22),
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    // width: 100
                    padding: EdgeInsets.all(4),
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: MColors.divideColor,
                      // color: MColors.primaryColor,
                    )),
                    child: Row(
                      children: [
                        Text('10条/页'),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildPageIndex() {
    var totalGroupSize = (totalCount / pageSize).ceilToDouble().toInt();
    return Wrap(
      spacing: 10,
      children: List.generate(
        totalGroupSize,
        (index) => InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: MColors.divideColor),
            ),
            width: 30,
            height: 30,
            child: Text('${index + 1}'),
          ),
        ),
      ),
    );
  }
}
