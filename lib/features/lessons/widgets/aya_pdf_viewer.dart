import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/theme/app_theme.dart';

class AyaPdfViewer extends StatefulWidget {
  final String pdfUrl;
  const AyaPdfViewer({super.key, required this.pdfUrl});

  @override
  State<AyaPdfViewer> createState() => _AyaPdfViewerState();
}

class _AyaPdfViewerState extends State<AyaPdfViewer> {
  late PdfViewerController _pdfViewController;
  bool _isReady = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _pdfViewController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: AyaColors.lavenderSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SfPdfViewer.network(
              widget.pdfUrl,
              controller: _pdfViewController,
              enableDoubleTapZooming: true,
              enableTextSelection: true,
              pageLayoutMode: PdfPageLayoutMode.continuous,
              scrollDirection: PdfScrollDirection.vertical,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                setState(() {
                  _isReady = true;
                  _errorMessage = null;
                });
              },
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                setState(() {
                  _errorMessage = 'Erro ao carregar o PDF: ${details.error}';
                  _isReady = false;
                });
              },
            ),
          ),
          if (!_isReady && _errorMessage == null)
            const Center(
              child: CircularProgressIndicator(color: AyaColors.turquoise),
            ),
          if (_errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AyaColors.textPrimary,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AyaColors.textPrimary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
