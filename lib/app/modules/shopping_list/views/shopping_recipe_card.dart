import 'dart:math';

import 'package:kitmate/app/helper/all_imports.dart';
import 'package:kitmate/app/modules/shopping_list/controllers/shopping_list_controller.dart';

class ShoppingRecipeCard extends StatefulWidget {
  ShoppingRecipeCard(
      {super.key, required this.controller, required this.recipe});
  ShoppingListController controller;
  Map recipe;
  bool expanded = false;

  @override
  State<ShoppingRecipeCard> createState() => _ShoppingRecipeCardState();
}

class _ShoppingRecipeCardState extends State<ShoppingRecipeCard> {
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
                  text: widget.recipe["label"],
                  maxLines: 2,
                  width: 160.w(context) - 9.t(context),
                  minFontSize: 10.t(context).floorToDouble(),
                  overflow: TextOverflow.ellipsis,
                  style: Styles.bold(
                    fontSize: 10.t(context),
                    color: AppColors.fontDark,
                  ),
                ),
                Spacer(),
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
                for (Map ingredient
                    in getKey(widget.recipe, ["ingredients"], []))
                  Row(
                    children: [
                      AppText(
                        text: getKey(ingredient, ["label"], ""),
                        style: Styles.regular(
                          color: AppColors.fontDark,
                          fontSize: 9.t(context),
                        ),
                        width: 105.w(context),
                      ),
                      Spacer(),
                      AppText(
                        text:
                            "${ingredient["quantity"]} ${ingredient["quantity_unit"]}"
                                .replaceAll("(1,2,3,4...)", ""),
                        width: 55.w(context),
                        style: Styles.bold(
                          fontSize: 7.t(context),
                          color: AppColors.fontDark,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
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
