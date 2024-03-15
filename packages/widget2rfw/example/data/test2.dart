import 'package:flutter/widgets.dart';
import 'package:rfw/rfw.dart';

Widget Counter(data) {
  return Container(
    color: const Color(0xFF66AACC),
    child: Center(
      child: Button(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              data.counter,
              style: const TextStyle(fontSize: 56.0, color: Color(0xFF000000)),
            ),
          ),
          onPressed: increment),
    ),
  );
}

void increment() {}

Widget Button(
    {DynamicMap? initialState,
    required Widget child,
    required void Function() onPressed,
    dynamic args}) {
  DynamicMap state = initialState ?? {'down': false};

  return GestureDetector(
    onTap: increment,
    onTapDown: (d) => state['down'] = true,
    onTapUp: (d) => state['down'] = false,
    onTapCancel: () => state['down'] = false,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      margin: state['down'] == false
          ? const EdgeInsets.only(left: 0.0, top: 0.0, right: 2.0, bottom: 2.0)
          : const EdgeInsets.only(left: 2.0, top: 2.0, right: 0.0, bottom: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: ShapeDecoration(
          shape: const StadiumBorder(side: BorderSide(width: 1.0)),
          gradient: const LinearGradient(
              begin: Alignment(-0.5, -0.25),
              end: Alignment(0.0, 0.5),
              colors: [Color(0xFFFFFF99), Color(0xFFEEDD00)],
              stops: [0.0, 1.0],
              tileMode: TileMode.mirror),
          shadows: state['down'] == false
              ? [
                  const BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 0.5,
                      offset: Offset(1.0, 1.0))
                ]
              : []),
      child: DefaultTextStyle(
        style: const TextStyle(color: Color(0xFF000000), fontSize: 32.0),
        child: child,
      ),
    ),
  );
}
