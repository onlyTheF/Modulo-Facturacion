
import 'package:facturacion/src/navigation_bar/nav_bar_button.dart';
import 'package:facturacion/src/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavBar extends ResponsiveWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget buildDesktop(BuildContext context) {
    return const DesktopNavBar();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return const MobileNavBar();
  }
}

class DesktopNavBar extends HookConsumerWidget {
  const DesktopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final isScrolled = ref.watch(scrolledProvider);
    //final navBarColor = isScrolled ? Colors.blue : Colors.white;
    final listItems = ['item1', 'item2'];


    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 40.0,
            ),
            const SizedBox(width: 10.0),
            // ignore: prefer_const_constructors
            Text(
              "PYMEs",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            Expanded(child: Container()),
            NavBarButton(
              onTap: () {},
              text: "Home",
            ),
            NavBarButton(
              onTap: () {},
              text: "Features",
            ),
            NavBarButton(
              onTap: () {},
              text: "Screenshots",
            ),
            /*Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical:4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 4)
              ),
              child: DropdownButton<String>(
                hint: Text("Item"),
                items: listItems.map(buildMenuItem).toList(),
                onChanged: (value) => listItems,
                iconSize: 36,
                icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                isExpanded: true,
              ),
            ),*/


          ],
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item)=> DropdownMenuItem(

  value: item,
  child: Text(
    item,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize:30),
  ),
);

class MobileNavBar extends HookConsumerWidget {
  const MobileNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerHeight = useState<double>(0.0);
    //final isScrolled = ref.watch(scrolledProvider);

    //final navBarColor = isScrolled ? Colors.blue : Colors.white;
    return Stack(
      children: [
        AnimatedContainer(
          margin: const EdgeInsets.only(top: 70.0),
          duration: const Duration(milliseconds: 350),
          curve: Curves.ease,
          height: containerHeight.value,
          child: SingleChildScrollView(
            child: Column(
              children: [
                NavBarButton(
                  text: "Home",
                  onTap: () {
                    //ref.read(currentPageProvider.state).state = homeKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Features",
                  onTap: () {
                    //ref.read(currentPageProvider.state).state = featureKey;
                    containerHeight.value = 0;
                  },
                ),
                NavBarButton(
                  text: "Screenshots",
                  onTap: () {
                    //ref.read(currentPageProvider.state).state = screenshotKey;
                    containerHeight.value = 0;
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  height: 30.0,
                ),
                const SizedBox(width: 10.0),
                // ignore: prefer_const_constructors
                Text(
                  "PYMEs",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 32),
                ),
                Expanded(
                  child: Container(),
                ),
                Material(
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      final height = containerHeight.value > 0 ? 0.0 : 240.0;
                      containerHeight.value = height;
                    },
                    // ignore: prefer_const_constructors
                    child: Icon(
                      Icons.menu,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
