import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';

class ZurichContainer extends StatelessWidget {

  final String? bannerImageUrl;

  const ZurichContainer({
    Key? key, this.bannerImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  bannerImageUrl != null ? Image.network(
      bannerImageUrl ?? '',
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded /
                progress.expectedTotalBytes!
                : null,

          ),
        );
      },
    ) : Image.asset(
            "assets/images/design/zurich_banner.png",
            width: MediaQuery.of(context).size.width,
          );
  }
}
