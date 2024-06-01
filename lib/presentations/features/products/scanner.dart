import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pos/presentations/features/cart/provider.dart';
import 'package:pos/presentations/features/products/provider.dart';
import 'package:provider/provider.dart';

import '../../commons/styles/color.dart';
import '../../commons/styles/text.dart';

class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({super.key});

  @override
  State<BarcodeScannerWithController> createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
  );

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  late ProductProvider _productProvider;
  late CartProvider _cartProvider;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
      print(_barcode?.rawValue);
      if(_barcode != null) {
        _productProvider.searchProducts(_barcode?.rawValue ?? "");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());

    Future.microtask(() {
      _productProvider = Provider.of<ProductProvider>(context, listen: false);
      _cartProvider = Provider.of<CartProvider>(context, listen: false);
      _productProvider.clearDisplayedProducts();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (bool) {
        _productProvider.displayAllProducts();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            MobileScanner(
              controller: controller,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ToggleFlashlightButton(controller: controller),
                        StartStopMobileScannerButton(controller: controller),
                        SwitchCameraButton(controller: controller),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            color: Colors.black,
                            child: Center(
                              child: Text("Selesai",
                                style: AppSText.body.copyWith(color: AppColor.secondary200),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,)
                      ],
                    ),
                    Consumer2<ProductProvider, CartProvider>(
                      builder: (context, data, dataInCart, child) {
                        return Container(
                          height: 100,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: Colors.white,
                                  width: _size.width * 90 / 100,
                                  child: Row(
                                    children: [
                                      // IMAGE
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.network(data.products[index].photoUrl ?? "", fit: BoxFit.cover,),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 10,),
                                      // CONTENT
                                      Expanded(
                                        child: Container(
                                          height: 100,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5,),
                                              Text(data.products[index].name ?? "",
                                                style: AppSText.title.copyWith(height: 1),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5,),
                                              Text("Rp ${data.products[index].price}",
                                                style: AppSText.title.copyWith(color: AppColor.secondary500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Expanded(child: Container()),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    dataInCart.isProductInCart(data.products[index])
                                                    ? Row(
                                                      children: [
                                                        Text("Jumlah: ",
                                                          style: AppSText.body,),
                                                        SizedBox(width: 10,),
                                                        Text("${_cartProvider.getProductCount(data.products[index])}",
                                                          style: AppSText.title.copyWith(color: AppColor.primary500),
                                                        )
                                                      ],
                                                    )
                                                    : Container()
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5,)
                                            ],
                                          ),
                                        ),
                                      ),
                                      !_cartProvider.isProductInCart(data.products[index])
                                      ? LayoutBuilder(
                                        builder: (context, constraints) {
                                          return InkWell(
                                            onTap: () {
                                              HapticFeedback.lightImpact();
                                              _cartProvider.increaseProduct(data.products[index]);
                                            },
                                            child: Container(
                                              width: 60,
                                              height: 100,
                                              color: AppColor.primary700,
                                              child: Center(
                                                child: Icon(Icons.add, color: Colors.white,),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                      : LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Container(
                                            width: 60,
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    HapticFeedback.lightImpact();
                                                    _cartProvider.increaseProduct(data.products[index]);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 49,
                                                    color: AppColor.primary700,
                                                    child: Center(
                                                      child: Icon(Icons.keyboard_arrow_up_sharp, color: Colors.white,),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    HapticFeedback.lightImpact();
                                                    _cartProvider.decreaseProduct(data.products[index]);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 49,
                                                    color: AppColor.primary700,
                                                    child: Center(
                                                      child: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 10,);
                              },
                              itemCount: data.products.length),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}

class StartStopMobileScannerButton extends StatelessWidget {
  const StartStopMobileScannerButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return IconButton(
            color: Colors.black,
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: () async {
              await controller.start();
            },
          );
        }

        return IconButton(
          color: Colors.red,
          icon: const Icon(Icons.stop),
          iconSize: 32.0,
          onPressed: () async {
            await controller.stop();
          },
        );
      },
    );
  }
}

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }

        final Widget icon;

        switch (state.cameraDirection) {
          case CameraFacing.front:
            icon = const Icon(Icons.camera_front, color: Colors.black, size: 20,);
          case CameraFacing.back:
            icon = const Icon(Icons.camera_rear, color: Colors.black, size: 20,);
        }

        return IconButton(
          iconSize: 32.0,
          icon: icon,
          onPressed: () async {
            await controller.switchCamera();
          },
        );
      },
    );
  }
}

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return IconButton(
              color: Colors.orangeAccent,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_auto, size: 20,),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.off:
            return IconButton(
              color: Colors.black,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_off, size: 20,),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.on:
            return IconButton(
              color: Colors.orangeAccent,
              iconSize: 32.0,
              icon: const Icon(Icons.flash_on, size: 20,),
              onPressed: () async {
                await controller.toggleTorch();
              },
            );
          case TorchState.unavailable:
            return const Icon(
              Icons.no_flash,
              color: Colors.grey,
            );
        }
      },
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({super.key, required this.error});

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller not ready.';
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Permission denied';
      case MobileScannerErrorCode.unsupported:
        errorMessage = 'Scanning is unsupported on this device';
      default:
        errorMessage = 'Generic Error';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}