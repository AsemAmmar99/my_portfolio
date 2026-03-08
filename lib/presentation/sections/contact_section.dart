import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_dimensions.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/common/section_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final subject =
        Uri.encodeComponent('Portfolio Contact â€” ${_nameCtrl.text}');
    final body = Uri.encodeComponent(
      'Name: ${_nameCtrl.text}\nEmail: ${_emailCtrl.text}\n\nMessage:\n${_msgCtrl.text}',
    );
    final uri = Uri.parse(
        'mailto:${AppConstants.email}?subject=$subject&body=$body');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }

    if (mounted) {
      setState(() => _sending = false);
      _nameCtrl.clear();
      _emailCtrl.clear();
      _msgCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Opening your email client...'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.sectionVerticalPadding),
      color: Theme.of(context).colorScheme.surface,
      child: ContentWrapper(
        child: AnimatedSection(
          sectionId: 'contact',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Get In Touch',
                subtitle: 'Have a project in mind? I\'d love to hear from you.',
              ),
              isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildContactInfo(context)),
        const SizedBox(width: AppDimensions.xxl),
        Expanded(flex: 3, child: _buildForm(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactInfo(context),
        const SizedBox(height: AppDimensions.xl),
        _buildForm(context),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Let\'s Build Something',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppDimensions.sm),
          Text(
            'Whether you have a project idea, need a technical consultation, '
            'or just want to say hi â€” my inbox is always open.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppDimensions.xl),
          _ContactItem(
            icon: Icons.mail_outline_rounded,
            title: 'Email',
            value: AppConstants.email,
            url: AppConstants.emailUrl,
          ),
          const SizedBox(height: AppDimensions.md),
          _ContactItem(
            icon: Icons.location_on_outlined,
            title: 'Location',
            value: AppConstants.location,
          ),
          const SizedBox(height: AppDimensions.xl),
          Text('Find Me Online',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppDimensions.md),
          Row(
            children: [
              _LinkBtn(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                url: AppConstants.githubUrl,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppDimensions.md),
              _LinkBtn(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                url: AppConstants.linkedInUrl,
                color: const Color(0xFF0A66C2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send a Message',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppDimensions.xl),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                prefixIcon: Icon(Icons.person_outline_rounded,
                    color: AppColors.textMuted, size: 20),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: AppDimensions.md),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Your Email',
                prefixIcon: Icon(Icons.mail_outline_rounded,
                    color: AppColors.textMuted, size: 20),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: AppDimensions.md),
            TextFormField(
              controller: _msgCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Your Message',
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Icon(Icons.message_outlined,
                      color: AppColors.textMuted, size: 20),
                ),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Message is required' : null,
            ),
            const SizedBox(height: AppDimensions.xl),
            SizedBox(
              width: double.infinity,
              child: GradientButton(
                label: _sending ? 'Sending...' : 'Send Message',
                icon: _sending ? null : Icons.send_rounded,
                onTap: _sending ? () {} : _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? url;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: AppDimensions.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelMedium),
            GestureDetector(
              onTap: url != null ? () => launchUrl(Uri.parse(url!)) : null,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: url != null
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      decoration:
                          url != null ? TextDecoration.underline : null,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LinkBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color color;

  const _LinkBtn({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  @override
  State<_LinkBtn> createState() => _LinkBtnState();
}

class _LinkBtnState extends State<_LinkBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: AppDimensions.animFast,
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withOpacity(0.15)
                : AppColors.bgPrimary,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(
                color: _hovered
                    ? widget.color.withOpacity(0.5)
                    : AppColors.bgBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(widget.icon, size: 14, color: widget.color),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                    color: widget.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



