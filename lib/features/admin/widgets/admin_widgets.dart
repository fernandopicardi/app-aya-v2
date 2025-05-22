import 'package:flutter/material.dart';
import '../models/admin_models.dart';
import 'package:app_aya_v2/core/theme/app_theme.dart';

class AdminStatsCard extends StatelessWidget {
  final AdminStats stats;

  const AdminStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visão Geral',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Total de Usuários',
                    value: stats.totalUsers.toString(),
                    icon: Icons.people,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Assinantes',
                    value: stats.totalSubscribers.toString(),
                    icon: Icons.star,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Conteúdos Recentes',
                    value: stats.recentContents.toString(),
                    icon: Icons.article,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Moderação Pendente',
                    value: stats.pendingModeration.toString(),
                    icon: Icons.flag,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class AdminActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const AdminActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon,
                  size: 32, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminUserListTile extends StatelessWidget {
  final AdminUser user;
  final VoidCallback onTap;
  final VoidCallback? onEditRole;
  final VoidCallback? onDeactivate;

  const AdminUserListTile({
    super.key,
    required this.user,
    required this.onTap,
    this.onEditRole,
    this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Text(
          user.name.isNotEmpty
              ? user.name[0].toUpperCase()
              : user.email[0].toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(user.name.isNotEmpty ? user.name : user.email),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEditRole != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditRole,
            ),
          if (onDeactivate != null)
            IconButton(
              icon: const Icon(Icons.block),
              onPressed: onDeactivate,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class AdminContentListTile extends StatelessWidget {
  final AdminContent content;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AdminContentListTile({
    super.key,
    required this.content,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        content.type == 'module'
            ? Icons.folder
            : content.type == 'folder'
                ? Icons.folder_open
                : Icons.article,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(content.title),
      subtitle: Text(
        '${content.type.toUpperCase()} • ${content.isPublished ? 'Publicado' : 'Rascunho'}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class AdminCommentListTile extends StatelessWidget {
  final AdminComment comment;
  final VoidCallback onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onDelete;

  const AdminCommentListTile({
    super.key,
    required this.comment,
    required this.onTap,
    this.onApprove,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: comment.isReported
            ? Colors.red
            : comment.isApproved
                ? Colors.green
                : Colors.grey,
        child: Icon(
          comment.isReported
              ? Icons.flag
              : comment.isApproved
                  ? Icons.check
                  : Icons.pending,
          color: Colors.white,
        ),
      ),
      title: Text(comment.content),
      subtitle: Text(
        '${comment.authorName} • ${comment.contentTitle}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onApprove != null && !comment.isApproved)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: onApprove,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class AdminChallengeListTile extends StatelessWidget {
  final AdminChallenge challenge;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AdminChallengeListTile({
    super.key,
    required this.challenge,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: challenge.isActive ? Colors.green : Colors.grey,
        child: Icon(
          challenge.isActive ? Icons.emoji_events : Icons.emoji_events_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(challenge.title),
      subtitle: Text(
        '${challenge.points} pontos • ${challenge.completedParticipants}/${challenge.totalParticipants} completos',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class AdminBadgeListTile extends StatelessWidget {
  final AdminBadge badge;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const AdminBadgeListTile({
    super.key,
    required this.badge,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(badge.iconUrl),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      title: Text(badge.name),
      subtitle: Text(
        '$badge.totalAwarded concedidos • ${badge.isActive ? 'Ativo' : 'Inativo'}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}
