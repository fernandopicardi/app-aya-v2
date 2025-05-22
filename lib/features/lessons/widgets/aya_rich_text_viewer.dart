import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
    return Container(
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
              child: Markdown(
                data: content.isNotEmpty ? content : 'Conteúdo não disponível',
                selectable: true,
                shrinkWrap: true,
                styleSheet: MarkdownStyleSheet(
                  h1: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                  h2: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                  h3: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                  p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary,
                      ),
                  blockquote: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary60,
                        fontStyle: FontStyle.italic,
                      ),
                  code: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AyaColors.turquoise,
                        backgroundColor: AyaColors.surface,
                        fontFamily: 'monospace',
                      ),
                  codeblockDecoration: BoxDecoration(
                    color: AyaColors.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  listBullet: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AyaColors.textPrimary,
                      ),
                  tableHead: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AyaColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                  tableBody: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AyaColors.textPrimary,
                      ),
                  tableBorder: TableBorder.all(
                    color: AyaColors.textPrimary.withOpacity(0.3),
                    width: 1,
                  ),
                  tableCellsPadding: const EdgeInsets.all(8),
                  horizontalRuleDecoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AyaColors.textPrimary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
