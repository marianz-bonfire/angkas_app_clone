import 'package:angkas_app_clone/app_colors.dart';
import 'package:angkas_app_clone/ui/widgets/action_section.dart';
import 'package:angkas_app_clone/ui/widgets/dashline_view.dart';
import 'package:angkas_app_clone/ui/widgets/location_section.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

  // Coordinates for center of the map
  final LatLng _initialPosition = LatLng(14.676041, 121.043700); // Example coordinates (Quezon City)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
          _buildUIOverlay(),
        ],
      ),
    );
  }

  // Step 3: Build the UI Overlay on top of the map
  Widget _buildUIOverlay() {
    return Column(
      children: [
        _topMenuButton(),
        Spacer(),
        _reminderCard(),
        _buildBottomCard(),
        _staySafeCard(),
        _bookingCard(),
      ],
    );
  }

  Widget _topMenuButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipOval(
          child: Material(
            child: InkWell(
              splashColor: AppColor.primaryColor, // Splash color
              onTap: () {},
              child: SizedBox(width: 32, height: 32, child: Icon(Icons.menu)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _reminderCard() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text('REMINDERS'),
      ),
    );
  }

  Widget _buildBottomCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.circle, color: AppColor.primaryColor),
                      Container(
                        height: 60,
                        width: 2,
                        decoration: DottedDecoration(
                            shape: Shape.line,
                            linePosition: LinePosition.left,
                            color: AppColor.textColor,
                            strokeWidth: 2),
                      ),
                      Icon(Icons.location_pin, color: Colors.orange),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LocationSelectionView(
                        title: 'Current Location',
                        address: '164 Balingasa St A. Bonifacio, Quezon City, Philippines',
                        onTap: () {},
                      ),
                      Divider(),
                      LocationSelectionView(
                        title: 'Drop Off Location',
                        address: 'Quezon City, Metro Manila, Philippines',
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionSelectionView(
                  title: 'Cash',
                  image: 'assets/icons/cash.png',
                  onTap: () {
                    _showBottomSheet(context, _buildBottomSheetPaymentMethod(context));
                  },
                ),
                VerticalDivider(),
                ActionSelectionView(
                  title: 'Promo',
                  image: 'assets/icons/promo.png',
                  onTap: () {
                    _showBottomSheet(context, _buildBottomSheetPaymentMethod(context));
                  },
                ),
                VerticalDivider(),
                ActionSelectionView(
                  title: 'Notes to Biker',
                  image: 'assets/icons/notes.png',
                  onTap: () {
                    _showBottomSheet(context, _buildBottomSheetNotes(context));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _staySafeCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/icons/background.png'), fit: BoxFit.fitWidth, alignment: Alignment.topCenter),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        leading: Image(width: 32, image: AssetImage('assets/icons/raincoat.png')),
        title: Row(
          children: [
            Text('Rent-A-Raincoat', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: AppColor.newColor,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Text(
                'NEW',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        subtitle: Text(
          'Stay dry & safe in the rain',
          style: TextStyle(color: AppColor.textColor),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.blue),
      ),
    );
  }

  Widget _bookingCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Image(width: 32, image: AssetImage('assets/icons/helmet.png')),
            title: InkWell(
              onTap: () {
                showServiceDialog(context);
              },
              child: Row(
                children: const [
                  Text('Passenger', style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 12,
                  ),
                ],
              ),
            ),
            trailing: Text('₱50.00', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 24),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: AppColor.primaryColor),
                    ),
                  ),
                ),
                child: Text('Book', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show bottom sheet
  void _showBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  Widget _buildBottomSheetPaymentMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Payment Method',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: AppColor.secondaryColor,
            child: ListTile(
              leading: Image(width: 24, image: AssetImage('assets/icons/cash.png')),
              title: Text('Cash', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(
                Icons.check_circle,
                size: 24,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              decoration: DottedDecoration(
                  shape: Shape.box, borderRadius: BorderRadius.circular(10), color: AppColor.primaryColor),
              child: ListTile(
                leading: Image(width: 24, image: AssetImage('assets/icons/cash.png')),
                title: Text(
                  'Link your GCash now!',
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 24),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return AppColor.primaryColor;
                    }
                    return AppColor.inactiveColor;
                  }),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    // As you said you dont need elevation. I'm returning 0 in both case
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return 0;
                      }
                      return 0; // Defer to the widget's default.
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: AppColor.inactiveColor),
                    ),
                  ),
                ),
                child: Text(
                  'Manage Payment Methods',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColor.primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 24),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: AppColor.primaryColor),
                    ),
                  ),
                ),
                child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetNotes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Notes to Biker',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Tell your rider any helpful info',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.textColor)),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: AppColor.primaryColor),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Notes to Biker",
              fillColor: Colors.white70,
            ),
          ),
          SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 24),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: AppColor.primaryColor),
                  ),
                ),
              ),
              child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  void showServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          insetPadding: const EdgeInsets.symmetric(vertical: 220, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi! Anong trip natin?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Select a service type',
                      style: TextStyle(color: AppColor.textColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                //color: AppColor.secondaryColor,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                     // tileColor: AppColor.secondaryColor,
                      leading: Image(width: 60, image: AssetImage('assets/car.png')),
                      title: Text('Passenger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      subtitle: Text(
                        'Safety ride a motorcycle taxi',
                        style: (TextStyle(color: AppColor.textColor)),
                      ),
                    ),
                    SizedBox(height: 2),
                    ListTile(
                     // tileColor: AppColor.secondaryColor,
                      leading: Image(width: 60, image: AssetImage('assets/box.png')),
                      title: Text('Padala', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      subtitle: Text(
                        'Send packages & other supplies (Please gamitin nyo naman)',
                        style: (TextStyle(color: AppColor.textColor)),
                      ),
                    ),
                    SizedBox(height: 2),
                    ListTile(
                      //tileColor: AppColor.secondaryColor,
                      leading: Image(width: 60, image: AssetImage('assets/car.png')),
                      title: Text('Angcars', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      subtitle: Text(
                        'Car Rider with maximum passenger',
                        style: (TextStyle(color: AppColor.textColor)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
