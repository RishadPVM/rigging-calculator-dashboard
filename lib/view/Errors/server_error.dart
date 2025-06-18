import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/nav/nav.dart';

class InternalServerErrorPage extends StatelessWidget {
  final void Function() onPressed;

  const InternalServerErrorPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 600
                  ? Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: _ErrorContent(onPressed: onPressed),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: _ErrorImage(),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: _ErrorImage(),
                        ),
                        _ErrorContent(onPressed: onPressed),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final void Function() onPressed;

  const _ErrorContent({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Internal Server Error',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit sed do',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => onPressed(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'REFRESH',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth > 1000 ? 400.0 : screenWidth * 0.6;

    return Image.asset(
      'assets/images/serverError.png',
      width: imageWidth,
      fit: BoxFit.contain,
      semanticLabel: 'Server Error Illustration',
    );
  }
}
