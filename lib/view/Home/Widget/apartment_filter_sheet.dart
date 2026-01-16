import 'package:flutter/material.dart';
import 'package:task/generated/l10n.dart';

class ApartmentFilterSheet extends StatefulWidget {
  const ApartmentFilterSheet({super.key});

  @override
  State<ApartmentFilterSheet> createState() => _ApartmentFilterSheetState();
}

class _ApartmentFilterSheetState extends State<ApartmentFilterSheet> {
  String? city;
  String? governorate;
  int? rooms;
  double minPrice = 0;
  double maxPrice = 100;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Text(  S.of(context).filter_apartments
            ,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          DropdownButtonFormField<String>(
            hint:  Text( S.of(context).governorate),
            items: ['Damascus', 'Latakia','Aleppo','Tartos']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => governorate = v,
          ),

          DropdownButtonFormField<String>(
            hint: Text( S.of(context).city),
            items: ['Damascus', 'Midan', 'Mazzeh','Jableh',]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => city = v,
          ),

          DropdownButtonFormField<int>(
            hint: Text( S.of(context).rooms),
            items: [1, 2, 3, 4, 5]
                .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                .toList(),
            onChanged: (v) => rooms = v,
          ),

          const SizedBox(height: 10),

          Text( S.of(context).price_range),
          RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: 0,
            max: 100,
            divisions: 20,
            onChanged: (values) {
              setState(() {
                minPrice = values.start;
                maxPrice = values.end;
              });
            },
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'governorate': governorate,
                'city': city,
                'rooms': rooms,
                'minPrice': minPrice,
                'maxPrice': maxPrice,
              });
            },
            child: Text( S.of(context).apply),
          ),
        ],
      ),
    );
  }
}
