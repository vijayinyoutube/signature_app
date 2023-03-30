import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature App'),
      ),
      body: Stack(
        children: [
          Container(
            height: 500,
            width: 500,
            color: Colors.red,
            child: HandSignature(
              control: control,
              color: Colors.blueGrey,
              type: SignatureDrawType.arc,
            ),
          ),
          CustomPaint(
            painter: DebugSignaturePainterCP(
              control: control,
              cp: false,
              cpStart: false,
              cpEnd: false,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final svg = control.toSvg();
              final png = await control.toImage();
              final json = control.toMap();

              control.importData(json);
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }
}
