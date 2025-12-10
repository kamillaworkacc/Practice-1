import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/glitter_particles.dart';
import '../../shared/widgets/kawaii_planet.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final String _qrData = 'https://hubblesite.org/images/gallery';
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  bool _isScanning = false;
  String? _scannedData;
  bool _cameraError = false;
  String? _errorMessage;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrViewController?.pauseCamera();
    }
    if (mounted && _isScanning) {
      _qrViewController?.resumeCamera();
    }
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    try {
      setState(() {
        _qrViewController = controller;
        _cameraError = false;
        _errorMessage = null;
      });

      controller.scannedDataStream.listen(
        (scanData) {
          if (scanData.code != null && mounted) {
            setState(() {
              _scannedData = scanData.code;
              _isScanning = false;
            });
            _qrViewController?.pauseCamera();
            _showScannedResult(scanData.code!);
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() {
              _cameraError = true;
              _errorMessage = 'Camera error: ${error.toString()}';
              _isScanning = false;
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _cameraError = true;
          _errorMessage = 'Failed to initialize camera: ${e.toString()}';
          _isScanning = false;
        });
      }
    }
  }

  Future<void> _showScannedResult(String data) async {
    final uri = Uri.tryParse(data);
    
    if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Opening Hubble Gallery! 🌌✨'),
              backgroundColor: AppTheme.spacePink,
            ),
          );
        }
      } else {
        if (mounted) {
          _showUrlErrorDialog(data);
        }
      }
    } else {
      if (mounted) {
        _showUrlErrorDialog(data);
      }
    }
    
    if (mounted) {
      setState(() {
        _scannedData = data;
      });
    }
  }
  
  void _showUrlErrorDialog(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned! ✨🎉'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scanned: $data 💫'),
                const SizedBox(height: 16),
                const Text('Could not open URL automatically.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK ✨'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleScanner() async {
    try {
      if (!_isScanning) {
        setState(() {
          _isScanning = true;
          _cameraError = false;
          _errorMessage = null;
          _scannedData = null;
        });
        await Future.delayed(const Duration(milliseconds: 300));
        if (mounted && _qrViewController != null) {
          await _qrViewController!.resumeCamera();
        }
      } else {
        await _qrViewController?.pauseCamera();
        setState(() {
          _isScanning = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _cameraError = true;
          _errorMessage = 'Camera access error: ${e.toString()}';
          _isScanning = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera error: Please check permissions 📷✨'),
            backgroundColor: AppTheme.spacePink,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.spaceDark,
                AppTheme.spacePurple.withOpacity(0.3),
              ],
            ),
          ),
        ),
        if (!_isScanning) ...[
          GlitterParticles(
            particleCount: 25,
            color: AppTheme.spacePink.withOpacity(0.6),
            speed: 0.7,
          ),
          FloatingPlanets(
            planetCount: 2,
            emojis: ['⭐', '🌟'],
          ),
        ],
        SafeArea(
          child: _isScanning && !_cameraError
              ? _buildScannerView()
              : _buildQRCodeView(),
        ),
      ],
    );
  }

  Widget _buildScannerView() {
    return Column(
      children: [
        AppBar(
          title: const Text('QR Scanner 📸✨'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _toggleScanner,
          ),
        ),
        Expanded(
          child: ClipRect(
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: AppTheme.spacePink,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: _toggleScanner,
            icon: const Icon(Icons.stop),
            label: const Text('Stop Scanning ✋💫'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.spacePink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQRCodeView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QR Code 💫✨',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 40),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.spaceLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: QrImageView(
                        data: _qrData,
                        version: QrVersions.auto,
                        size: 250.0,
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.spaceDark,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'NASA Hubble Pictures Gallery 🔭✨',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Scan this QR code to explore amazing Hubble space telescope images! 🌌',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(_qrData);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Opening Hubble Gallery! 🌌✨'),
                        backgroundColor: AppTheme.spacePink,
                      ),
                    );
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Could not open Hubble Gallery 🚀'),
                        backgroundColor: AppTheme.spacePink,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open Hubble Gallery 🌌✨'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.spacePurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_cameraError) ...[
              Card(
                color: AppTheme.spacePink.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.orange,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Camera Error 📷',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _errorMessage ?? 'Unable to access camera. Please check permissions.',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton.icon(
              onPressed: _toggleScanner,
              icon: const Icon(Icons.qr_code_scanner),
              label: Text(_cameraError ? 'Retry Scanner 📸✨' : 'Scan QR Code 📸💫'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.spacePink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            if (_scannedData != null) ...[
              const SizedBox(height: 24),
              Card(
                color: AppTheme.spacePurple.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Last scanned: 📸✨',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _scannedData!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


