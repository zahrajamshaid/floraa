import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomRowWidget extends StatefulWidget {
  final String text;
  final ValueSetter<bool>? onChanged; // Make onChanged optional
  final String? svgPath;
  final bool showToggleButton; // Make the toggle button optional

  const CustomRowWidget({super.key, 
    required this.text,
    this.onChanged, // Make onChanged optional
    this.svgPath,
    this.showToggleButton = false, // Provide a default value of true
  });

  @override
  _CustomRowWidgetState createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<CustomRowWidget> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth;

        return Container(
          width: containerWidth,
          height: 66,
          padding: const EdgeInsets.symmetric(horizontal: 33),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.25, color: Color(0xFF2C2015))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (widget.svgPath != null)
                SvgPicture.asset(widget.svgPath!, width: 28, height: 28),
              if (widget.svgPath != null) const SizedBox(width: 10),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF2C2015),
                  fontFamily: 'Dosis',
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (widget.showToggleButton && widget.onChanged != null)
                Switch(
                  value: isToggled,
                  onChanged: (value) {
                    setState(() {
                      isToggled = value;
                    });
                    widget.onChanged!(isToggled); // Invoke onChanged if it's not null
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                ),
            ],
          ),
        );
      },
    );
  }
}
