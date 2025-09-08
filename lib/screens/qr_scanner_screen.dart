import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'safety_result_screen.dart';
import '../services/url_validator_service.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with TickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true;
  bool hasPermission = false;
  late AnimationController _animationController;
  late Animation<double> _scanLineAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scanLineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      hasPermission = status == PermissionStatus.granted;
    });
  }

  void _onDetect(BarcodeCapture capture) {
    if (!isScanning) return;

    setState(() {
      isScanning = false;
    });

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        _processQRCode(code);
      }
    }
  }

  Future<void> _processQRCode(String code) async {
    if (!mounted) return;
    
    // Show loading animation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if it's a URL
    if (code.startsWith('http://') || code.startsWith('https://')) {
      final result = await URLValidatorService.validateURL(code);
      if (!mounted) return;
      
      Navigator.pop(context); // Close loading dialog
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SafetyResultScreen(
            url: code,
            result: result,
            isFromQR: true,
          ),
        ),
      );
    } else {
      // For non-URL QR codes, show as safe
      if (!mounted) return;
      
      Navigator.pop(context); // Close loading dialog
      
      final result = URLValidationResult(
        isSafe: true,
        riskLevel: RiskLevel.low,
        message: '✅ SAFE: This QR code contains text data',
        details: 'The QR code contains: $code',
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SafetyResultScreen(
            url: code,
            result: result,
            isFromQR: true,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasPermission) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'QR Scanner',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'Camera Permission Required',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please allow camera access to scan QR codes',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _checkPermission,
                child: const Text('Grant Permission'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_off, color: Colors.white),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.camera_rear, color: Colors.white),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
          ),
          _buildScannerOverlay(),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
      ),
      child: Stack(
        children: [
          // Top overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          // Bottom overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          // Left overlay
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            width: (MediaQuery.of(context).size.width - 250) / 2,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          // Right overlay
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            right: 0,
            width: (MediaQuery.of(context).size.width - 250) / 2,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
          // Scanning area
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Corner decorations
                  ...List.generate(4, (index) {
                    return Positioned(
                      top: index < 2 ? 0 : null,
                      bottom: index >= 2 ? 0 : null,
                      left: index % 2 == 0 ? 0 : null,
                      right: index % 2 == 1 ? 0 : null,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border(
                            top: index < 2
                                ? const BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                            bottom: index >= 2
                                ? const BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                            left: index % 2 == 0
                                ? const BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                            right: index % 2 == 1
                                ? const BorderSide(color: Colors.green, width: 4)
                                : BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  }),
                  // Animated scan line
                  AnimatedBuilder(
                    animation: _scanLineAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: _scanLineAnimation.value * 250 - 2,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.green,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Instructions
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Position QR code within the frame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Scanning...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
