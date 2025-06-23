import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:luna_3/core/common/widgets/custom_app_bar.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/features/food_logging/controllers/barcode_scanner_controller.dart';
import 'package:luna_3/features/food_logging/controllers/scanner_ui_controller.dart';

class BarcodeScannerScreen extends GetView<BarcodeScannerController> {
  static const routeName = '/barcode-scanner';
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scannerUIController = Get.put(ScannerUIController());
    final controller = Get.put(BarcodeScannerController());
    final screenSize = MediaQuery.of(context).size;
    final scanWindow = screenSize.width * 0.85;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomAppBar(
                title: 'Scan Barcode',
                showBackButton: true,
                onBackPressed: () => Get.back(),
                actions: [
                  Obx(() {
                    if (!scannerUIController.isInitialized.value)
                      return const SizedBox();
                    return IconButton(
                      icon: Icon(
                        scannerUIController.isFlashOn.value
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: scannerUIController.toggleFlash,
                    );
                  }),
                  Obx(() {
                    if (!scannerUIController.isInitialized.value)
                      return const SizedBox();
                    return IconButton(
                      icon: Icon(
                        scannerUIController.isFrontCamera.value
                            ? Icons.camera_front
                            : Icons.camera_rear,
                        color: Colors.white,
                      ),
                      onPressed: scannerUIController.toggleCamera,
                    );
                  }),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() {
                    if (!scannerUIController.isInitialized.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    return MobileScanner(
                      controller: scannerUIController.cameraController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          final String? code = barcodes.first.rawValue;
                          if (code != null) {
                            controller.handleBarcodeScan(code);
                          }
                        }
                      },
                    );
                  }),
                  CustomPaint(
                    painter: ScannerOverlay(scanWindow),
                    child: const SizedBox.expand(),
                  ),
                  Positioned(
                    bottom: 40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Align barcode within the frame',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.isLoading) {
                      return Container(
                        color: Colors.black54,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  final double scanWindow;

  ScannerOverlay(this.scanWindow);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black54
          ..style = PaintingStyle.fill;

    final windowRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanWindow,
      height: scanWindow / 2, // Make it rectangular for barcode scanning
    );

    // Draw semi-transparent overlay
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(
          RRect.fromRectAndRadius(windowRect, const Radius.circular(12)),
        ),
      ),
      paint,
    );

    // Draw scan window border
    final borderPaint =
        Paint()
          ..color = AppColors.secondary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    // Draw corner markers
    final cornerLength = scanWindow * 0.1;
    final cornerPath = Path();

    // Top-left corner
    cornerPath.moveTo(windowRect.left, windowRect.top + cornerLength);
    cornerPath.lineTo(windowRect.left, windowRect.top);
    cornerPath.lineTo(windowRect.left + cornerLength, windowRect.top);

    // Top-right corner
    cornerPath.moveTo(windowRect.right - cornerLength, windowRect.top);
    cornerPath.lineTo(windowRect.right, windowRect.top);
    cornerPath.lineTo(windowRect.right, windowRect.top + cornerLength);

    // Bottom-left corner
    cornerPath.moveTo(windowRect.left, windowRect.bottom - cornerLength);
    cornerPath.lineTo(windowRect.left, windowRect.bottom);
    cornerPath.lineTo(windowRect.left + cornerLength, windowRect.bottom);

    // Bottom-right corner
    cornerPath.moveTo(windowRect.right - cornerLength, windowRect.bottom);
    cornerPath.lineTo(windowRect.right, windowRect.bottom);
    cornerPath.lineTo(windowRect.right, windowRect.bottom - cornerLength);

    canvas.drawPath(cornerPath, borderPaint);

    // Draw scan line animation
    final scanLinePaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondary.withValues(alpha: 0.0),
              AppColors.secondary.withValues(alpha: 0.8),
              AppColors.secondary.withValues(alpha: 0.0),
            ],
          ).createShader(windowRect);

    canvas.drawRect(
      Rect.fromLTWH(
        windowRect.left,
        windowRect.top + (windowRect.height * 0.5),
        windowRect.width,
        3,
      ),
      scanLinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
