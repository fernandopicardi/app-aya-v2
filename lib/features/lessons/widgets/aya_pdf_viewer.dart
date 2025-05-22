import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../core/theme/app_theme.dart';

class AyaPdfViewer extends StatefulWidget {
  final String pdfUrl;
  const AyaPdfViewer({super.key, required this.pdfUrl});

  @override
  State<AyaPdfViewer> createState() => _AyaPdfViewerState();
}

class _AyaPdfViewerState extends State<AyaPdfViewer> {
  int _pages = 0;
  int _currentPage = 0;
  bool _isReady = false;
  String? _errorMessage;
  PDFViewController? _pdfViewController;

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
            child: PDFView(
              filePath: widget.pdfUrl,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onRender: (_pages) {
                setState(() {
                  this._pages = _pages!;
                  _isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  _errorMessage = error.toString();
                });
              },
              onPageError: (page, error) {
                setState(() {
                  _errorMessage = '$page: ${error.toString()}';
                });
              },
              onViewCreated: (controller) {
                _pdfViewController = controller;
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page ?? 0;
                });
              },
            ),
          ),
          if (!_isReady)
            const Center(
              child: CircularProgressIndicator(color: AyaColors.turquoise),
            ),
          if (_errorMessage != null)
            Center(
              child: Text(
                'Erro ao carregar PDF\n$_errorMessage',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AyaColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          // Page indicator
          if (_isReady && _errorMessage == null)
            Positioned(
              bottom: 12,
              right: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AyaColors.surface.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  '${_currentPage + 1} / $_pages',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
