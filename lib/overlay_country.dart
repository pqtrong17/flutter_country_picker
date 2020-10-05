import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class OverlayCountry {
  static OverlayEntry createOverlayEntry(
      {GlobalKey key,
      LayerLink layerLink,
      TextStyle countryTextStyle,
      TextStyle dialingCodeTextStyle,
      ValueChanged<Country> onTapItem}) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    List<Country> _listCountry = Country.ALL;
    print('${offset.dx} --- ${offset.dy}');
    return OverlayEntry(
        builder: (context) => Positioned(
              top: size.height,
              width: size.width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(offset.dx, size.height),
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    width: size.width,
                    height: 300,
                    color: Colors.yellow,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _listCountry.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Country _country = _listCountry[index];
                        return InkWell(
                            onTap: () => onTapItem(_country),
                            child: Container(
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
                                      child: RichText(
                                        text: TextSpan(children: <InlineSpan>[
                                          WidgetSpan(
                                            child: Text(
                                                _country.name.toUpperCase(),
                                                style: countryTextStyle
                                            )
                                          ),
                                          WidgetSpan(
                                            child: Container(
                                              margin: EdgeInsets.only(left: 8),
                                              child: Text(
                                                  "+" + _country.dialingCode,
                                                  style: dialingCodeTextStyle
                                              ),
                                            )
                                          ),
                                        ]),
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
