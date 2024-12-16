import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'text_interface.dart'; // Make sure to import text_interface.dart

class BluetoothApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth Communication',
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final flutterReactiveBle = FlutterReactiveBle();
  final List<DiscoveredDevice> _discoveredDevices = [];
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  StreamSubscription<ConnectionStateUpdate>? _connectionSubscription;
  bool _isScanning = false;
  bool _isConnected = false;
  String _connectionMessage = "";

  @override
  void initState() {
    super.initState();
    _checkBluetoothStatus();
  }

  // Checking Bluetooth status and permissions
  void _checkBluetoothStatus() {
    flutterReactiveBle.statusStream.listen((status) {
      if (status == BleStatus.ready) {
        print("Bluetooth is ready.");
      } else if (status == BleStatus.unauthorized) {
        print("Bluetooth is unauthorized. Please enable Bluetooth and grant permissions.");
        setState(() {
          _connectionMessage = "Bluetooth is unauthorized.";
        });
      } else if (status == BleStatus.unknown) {
        print("Bluetooth status is unknown.");
      } else if (status == BleStatus.poweredOff) {
        print("Bluetooth is powered off. Please turn it on.");
        setState(() {
          _connectionMessage = "Bluetooth is powered off.";
        });
      }
    });
  }

  // Start scanning for devices
  void _startScanning() {
    setState(() {
      _isScanning = true;
      _discoveredDevices.clear();
    });

    _scanSubscription = flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      setState(() {
        if (!_discoveredDevices.any((d) => d.id == device.id)) {
          _discoveredDevices.add(device);
        }
      });
    }, onError: (error) {
      print("Error scanning for devices: $error");
    });

    // Stop scanning after 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      _stopScanning();
    });
  }

  // Stop scanning for devices
  void _stopScanning() {
    _scanSubscription?.cancel();
    setState(() {
      _isScanning = false;
    });
  }

  // Connect to the selected device
  void _connectToDevice(DiscoveredDevice device) async {
    setState(() {
      _isConnected = false;
      _connectionMessage = "Connecting to ${device.name}...";
    });

    // Delay for 5 seconds to simulate connection time
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      _isConnected = true;
      _connectionMessage = "Connected to ${device.name}!";
    });

    // Navigate to TextInterface screen after the delay
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextInterface(
          onSendMessage: _sendMessage,
          receivedMessages: ["hello"], // Sample received messages
        ),
      ),
    );

    _connectionSubscription = flutterReactiveBle.connectToDevice(
      id: device.id,
      connectionTimeout: const Duration(seconds: 100),
    ).listen(
          (connectionState) {
        if (connectionState.connectionState == DeviceConnectionState.disconnected) {
          setState(() {
            _isConnected = false;
            _connectionMessage = "Disconnected from ${device.name}";
          });
          print("Disconnected from device.");
        }
      },
      onError: (error) {
        setState(() {
          _isConnected = false;
          _connectionMessage = "Connection failed: $error";
        });
        print("Connection failed: $error");
      },
    );
  }

  // Send message to the connected device
  void _sendMessage(String message) {
    print("Sending message: $message");
    // Add your Bluetooth message sending logic here
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1CCE5),
      appBar: AppBar(
        title: Text('Connection'),
        backgroundColor: Color(0xFFA594DE),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: _isScanning ? null : _startScanning,
                child: Text(_isScanning ? 'Scanning...' : 'Start Scanning'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: _discoveredDevices.isEmpty
                  ? Text("No devices found")
                  : Container(),
            ),
            SizedBox(height: 20),
            if (_discoveredDevices.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _discoveredDevices.length,
                  itemBuilder: (context, index) {
                    final device = _discoveredDevices[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(device.name.isEmpty ? "Unnamed Device" : device.name),
                        subtitle: Text("MAC: ${device.id}"),
                        trailing: IconButton(
                          icon: Icon(Icons.bluetooth),
                          onPressed: () {
                            _connectToDevice(device);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (_connectionMessage.isNotEmpty)
              Text(
                _connectionMessage,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontFamily: 'InriaSans'),
              ),
            if (_isConnected)
              Text(
                "Device is connected!",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontFamily: 'InriaSans'),
              ),
          ],
        ),
      ),
    );
  }
}
