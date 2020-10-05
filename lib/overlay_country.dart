import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class OverlayCountry {
  static OverlayEntry createOverlayEntry(
      {GlobalKey key,
      double height,
      LayerLink layerLink,
      TextStyle countryTextStyle,
      TextStyle dialingCodeTextStyle,
      ValueChanged<Country> onTapItem,
      Color colorBorder,
      double borderRadius}) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    List<Country> _listCountry = Country.ALL;
    return OverlayEntry(
        builder: (context) => Positioned(
              top: size.height,
              width: size.width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(offset.dx, size.height + 6),
                child: Material(
                  child: Container(
                    width: size.width,
                    height: height ?? 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorBorder ?? Colors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(borderRadius ?? 4)
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: _listCountry.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Country _country = _listCountry[index];
                        return InkWell(
                            onTap: () => onTapItem(_country),
                            child: Container(
                              padding: EdgeInsets.only(bottom: index == _listCountry.length - 1 ? 0 : 8),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      _country.asset,
                                      package: "flutter_country_picker",
                                      height: 24.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                                child: Text(
                                                  _country.name.toUpperCase(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: countryTextStyle,
                                                  maxLines: 1,)),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 8),
                                            child: Text(
                                              "+" + _country.dialingCode,
                                              style: dialingCodeTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              ),
            ));
  }
}
