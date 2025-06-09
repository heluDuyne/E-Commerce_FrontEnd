import 'package:flutter/material.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  double _priceValue = 80;
  int _selectedRating = 5;
  String _selectedCategory = 'Crop Tops';
  List<String> _selectedDiscounts = ['50% off', '40% off'];
  final List<Color> _colors = [
    Colors.amber,
    Colors.red,
    Colors.black,
    Colors.teal,
    Colors.brown,
    Colors.grey,
    Colors.pinkAccent,
  ];
  int _selectedColorIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.centerRight,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Icon(Icons.tune),
                ],
              ),
              const SizedBox(height: 24),

              const Text("Price"),
              RangeSlider(
                values: RangeValues(10, _priceValue),
                min: 10,
                max: 80,
                divisions: 7,
                labels: RangeLabels("\$10", "\$${_priceValue.toStringAsFixed(0)}"),
                onChanged: (range) {
                  setState(() => _priceValue = range.end);
                },
              ),

              const SizedBox(height: 16),
              const Text("Color"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List.generate(_colors.length, (index) {
                  final color = _colors[index];
                  final isSelected = _selectedColorIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColorIndex = index),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: color,
                      child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),
              const Text("Star Rating"),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (i) {
                  final value = i + 1;
                  final isSelected = value == _selectedRating;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRating = value),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? Colors.black : Colors.transparent,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        "★$value",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),
              const Text("Category"),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                borderRadius: BorderRadius.circular(12),
                items: ['Crop Tops', 'T-Shirts', 'Pants', 'Sweaters'].map((c) {
                  return DropdownMenuItem<String>(
                    value: c,
                    child: Text(c),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),

              const SizedBox(height: 20),
              const Text("Discount"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['50% off', '40% off', '30% off', '25% off'].map((d) {
                  final selected = _selectedDiscounts.contains(d);
                  return FilterChip(
                    label: Text(d),
                    selected: selected,
                    onSelected: (v) {
                      setState(() {
                        if (selected) {
                          _selectedDiscounts.remove(d);
                        } else {
                          _selectedDiscounts.add(d);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _priceValue = 80;
                        _selectedRating = 5;
                        _selectedCategory = 'Crop Tops';
                        _selectedColorIndex = 2;
                        _selectedDiscounts.clear();
                      });
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // You can pass selected filters here if needed
                    },
                    child: const Text("Apply"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}