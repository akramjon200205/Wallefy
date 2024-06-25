import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:wallefy/config/constants/app_colors.dart';
import 'package:wallefy/presentation/components/gradient_button.dart';

class ScanerWidget extends StatefulWidget {
  const ScanerWidget({super.key});

  @override
  State<ScanerWidget> createState() => _ScanerWidgetState();
}

class _ScanerWidgetState extends State<ScanerWidget> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          log(barcode.type.toString());
          log('Barcode found! ${barcode.rawValue}');
        }
        // controller.stop();
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.black,
          builder: (context) {
            return Container(
              height: 100,
              color: AppColors.black,
              child: Center(
                child: GradientButton(
                  onPressed: () {
                    controller.start();
                    Navigator.pop(context);
                  },
                  text: 'Close ${barcodes[0].rawValue}',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

