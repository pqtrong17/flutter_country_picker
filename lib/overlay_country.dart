import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class OverlayCountry {
//  void _insertCountryPicker(BuildContext context){
//    if(_overlayEntry != null){
//      _overlayEntry = null;
//    }
//    _removeCountryPicker();
//    this._overlayEntry = this._createOverlayEntry();
//    Overlay.of(context).insert(this._overlayEntry);
//    _isShowingOverlay = true;
//  }
//
//  void _removeCountryPicker(){
//    if (_isShowingOverlay) {
//      this._overlayEntry.remove();
//      _overlayEntry = null;
//      _isShowingOverlay = false;
//    }
//  }

//  void _onTapItem(Country _country){
//    _removeCountryPicker();
//  }

  static OverlayEntry _createOverlayEntry(
      {GlobalKey key,
      LayerLink layerLink,
      TextStyle countryTextStyle,
      TextStyle dialingCodeTextStyle,
      ValueChanged<Country> onTapItem}) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var size = renderBox.size;
    List<Country> _listCountry = Country.ALL;
    return OverlayEntry(
        builder: (context) => Positioned(
              top: size.height,
              width: size.width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, 48),
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    width: size.width,
                    height: 300,
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
                                      height: 24.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: RichText(
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: _country.name.toUpperCase(),
                                            style: countryTextStyle),
                                        TextSpan(
                                            text: _country.dialingCode,
                                            style: dialingCodeTextStyle),
                                      ]),
                                    ),
                                  )
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
