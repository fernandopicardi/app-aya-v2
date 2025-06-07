import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:app/core/theme/app_colors.dart'; // For styling

class PdfViewerWidget extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerWidget({
    super.key,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Validate URL
    final Uri? uri = Uri.tryParse(pdfUrl);
    // Basic check for empty string or non-HTTP/HTTPS schemes
    if (pdfUrl.isEmpty || uri == null || (!uri.isScheme('http') && !uri.isScheme('https'))) {
       return const Center(
        child: Text(
          'Invalid or unsupported PDF URL.', // More descriptive error
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return SfPdfViewer.network(
      pdfUrl,
      // initialScrollOffset: const Offset(0, 0), // Example property
      // initialZoomLevel: 1.0, // Example property
      // pageLayoutMode: PdfPageLayoutMode.continuous, // Example property
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        // print("Error loading PDF: ${details.error}");
        // print("Description: ${details.description}");
        // Optionally, update UI to show error message to user through a state management solution
        // For now, the SfPdfViewer might show its own error UI or a blank space.
        // Consider returning a user-friendly error widget from here if SfPdfViewer doesn't handle UI well.
      },
      // Other properties like onPageChanged, controller, etc. can be added as needed.
    );
  }
}
