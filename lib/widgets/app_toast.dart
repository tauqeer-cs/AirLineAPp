import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Toast {
  bool _isVisible = false;
  late BuildContext context;
  static final Toast _toast = Toast._internal();

  factory Toast() {
    return _toast;
  }

  Toast._internal();

  static Toast of(BuildContext context) {
    Toast toast = Toast();
    toast.context = context;
    return toast;
  }

  show({
    bool success = false,
    Duration duration = const Duration(seconds: 3),
    Widget? child,
    String? message,
  }) {
    // Prevent from showing multiple Widgets at the same time
    if (_isVisible) {
      return;
    }

    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          right: 20,
          left: 20,
          top: MediaQuery.of(context).padding.top +
              AppBar().preferredSize.height +
              20,
          child: ToastDialog(
            success: success,
            message: message,
            onClose: () {
              overlayEntry?.remove();
              overlayEntry = null;
            },
            child: child,
          ),
        );
      },
    );

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Overlay.of(context)?.insert(overlayEntry!);
      await Future.delayed(duration);

      overlayEntry?.remove();

      _isVisible = false;
    });
  }
}

class ToastDialog extends StatelessWidget {
  final Function()? onClose;
  final Widget? child;
  final bool success;
  final String? message;

  const ToastDialog({
    Key? key,
    this.onClose,
    this.child,
    this.message,
    required this.success,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              color: Theme.of(context).shadowColor,
              blurRadius: 50,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        child: Row(
          children: <Widget>[
            Visibility(
              visible: success,
              replacement: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                ),
                child: const OverflowBox(
                  maxHeight: 44,
                  maxWidth: 44,
                  child: Icon(
                    Icons.error,
                    size: 44,
                    color: Color(0xFFFF4E58),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF23BF9A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: child ??
                    Text(
                      message ?? '',
                    ),
              ),
            ),
            InkWell(
              onTap: onClose,
              child: const Icon(
                Icons.close,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
