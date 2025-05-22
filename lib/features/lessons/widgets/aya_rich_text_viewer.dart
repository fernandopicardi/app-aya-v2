import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
        children: [
          if (thumbnailUrl != null) ...[
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                thumbnailUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
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
          ],
          Expanded(
            child: Markdown(
              data: content,
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
                      height: 1.5,
                    ),
                blockquote: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AyaColors.textPrimary60,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                code: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      backgroundColor: AyaColors.textPrimary.withOpacity(0.1),
                      color: AyaColors.turquoise,
                    ),
                codeblockDecoration: BoxDecoration(
                  color: AyaColors.textPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                listBullet: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AyaColors.turquoise,
                    ),
                tableHead: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AyaColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                tableBody: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AyaColors.textPrimary,
                    ),
                tableBorder: TableBorder.all(
                  color: AyaColors.textPrimary.withOpacity(0.2),
                ),
                tableCellsPadding: const EdgeInsets.all(8),
                horizontalRuleDecoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AyaColors.textPrimary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                blockquoteDecoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: AyaColors.turquoise,
                      width: 4,
                    ),
                  ),
                ),
                blockquotePadding: const EdgeInsets.only(left: 16),
                blockSpacing: 16,
                tableColumnWidth: const FlexColumnWidth(),
                tableCellsDecoration: BoxDecoration(
                  color: AyaColors.textPrimary.withOpacity(0.05),
                ),
              ),
              selectable: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}
