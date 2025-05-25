import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';

class AyaRichTextViewer extends StatelessWidget {
  final String content;
  final String? thumbnailUrl;

  const AyaRichTextViewer({
    super.key,
    required this.content,
    this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: AyaColors.lavenderSoft,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnailUrl != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: thumbnailUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: AyaColors.lavenderSoft,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AyaColors.turquoise,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: AyaColors.lavenderSoft,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AyaColors.textPrimary,
                      size: 48,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: content.isEmpty
                    ? Center(
                        child: Text(
                          'Conteúdo não disponível.',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AyaColors.textPrimary,
                                  ),
                        ),
                      )
                    : Html(
                        data: content,
                        style: {
                          'body': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(16),
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'h1': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(32),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'h2': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(28),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'h3': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(24),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'p': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(16),
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'blockquote': Style(
                            color: AyaColors.textPrimary40,
                            fontStyle: FontStyle.italic,
                            fontSize: FontSize(16),
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'code': Style(
                            color: AyaColors.turquoise,
                            backgroundColor: AyaColors.surface,
                            fontFamily: 'monospace',
                            fontSize: FontSize(14),
                          ),
                          'pre': Style(
                            backgroundColor: AyaColors.surface,
                            padding: HtmlPaddings.all(8),
                          ),
                          'ul': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(16),
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'ol': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(16),
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'table': Style(
                            border: Border.all(color: AyaColors.textPrimary40),
                            padding: HtmlPaddings.all(8),
                          ),
                          'th': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(18),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter, Roboto, sans-serif',
                          ),
                          'td': Style(
                            color: AyaColors.textPrimary,
                            fontSize: FontSize(14),
                            fontFamily: 'Roboto',
                          ),
                          'hr': Style(
                            border: Border(
                              top: BorderSide(
                                color: AyaColors.textPrimary40,
                                width: 1,
                              ),
                            ),
                          ),
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
