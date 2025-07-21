import 'dart:math';

import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/modules/shopping_list/controllers/shopping_list_controller.dart';

class ShoppingIngredientCard extends StatefulWidget {
  ShoppingIngredientCard(
      {super.key, required this.controller, required this.ingredient});
  ShoppingListController controller;
  Map ingredient;
  bool expanded = false;

  @override
  State<ShoppingIngredientCard> createState() => _ShoppingIngredientCardState();
}

class _ShoppingIngredientCardState extends State<ShoppingIngredientCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.expanded = !widget.expanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 11.w(context),
              vertical: 11.h(context),
            ),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            width: 196.w(context),
            child: Row(
              children: [
                AppText(
                  text: widget.ingredient["label"],
                  maxLines: 2,
                  width: 105.w(context) - 9.t(context),
                  minFontSize: 10.t(context).floorToDouble(),
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bold(
                    fontSize: 10.t(context),
                    color: AppColors.fontDark,
                  ),
                ),
                Spacer(),
                AppText(
                  text:
                      "${widget.ingredient["quantity"]} ${widget.ingredient["quantity_unit"]}"
                          .replaceAll("(1,2,3,4...)", ""),
                  width: 55.w(context),
                  style: Styles.bold(
                    fontSize: 7.t(context),
                    color: AppColors.fontDark,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  width: 4.w(context),
                ),
                Transform.rotate(
                  angle: widget.expanded ? -pi / 2 : pi / 2,
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 9.t(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.expanded)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 11.w(context),
              vertical: 5.h(context),
            ),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            width: 196.w(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (Map recipe in getKey(widget.ingredient, ["recipes"], []))
                  AppText(
                    text: getKey(recipe, ["label"], ""),
                    style: Styles.regular(
                      color: AppColors.fontDark,
                      fontSize: 9.t(context),
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(
          height: 5.h(context),
        ),
      ],
    );
  }
}
