import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LinkGeneratorView extends StatefulWidget {
  const LinkGeneratorView({super.key});

  @override
  State<LinkGeneratorView> createState() => _LinkGeneratorViewState();
}

class _LinkGeneratorViewState extends State<LinkGeneratorView> {
  final _formKey = GlobalKey<FormState>();
  final _familyCtrl = TextEditingController(text: 'Familia López');
  final _countCtrl = TextEditingController(text: '4');

  String? _generatedUrl;

  @override
  void dispose() {
    _familyCtrl.dispose();
    _countCtrl.dispose();
    super.dispose();
  }

  Uri _buildInviteUri(String family, int count) {
    // Si estás en raíz:
    return Uri.parse(Uri.base.origin).replace(
      path: '/', // cambia a '/invitacion/' si usas subcarpeta
      queryParameters: {
        'f': family.trim(),
        'n': '$count',
      },
    );
  }

  void _generate() {
    if (!_formKey.currentState!.validate()) return;

    final fam = _familyCtrl.text.trim();
    final n = int.parse(_countCtrl.text.trim());
    final uri = _buildInviteUri(fam, n);

    setState(() => _generatedUrl = uri.toString());
  }

  Future<void> _copyUrl() async {
    if (_generatedUrl == null) return;
    await Clipboard.setData(ClipboardData(text: _generatedUrl!));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enlace copiado')),
    );
  }

  void _openPreview() {
    if (_generatedUrl == null) return;
    // Como es la misma app, navegamos internamente a "/"
    final uri = Uri.parse(_generatedUrl!);
    context.go(Uri(path: '/', queryParameters: uri.queryParameters).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar enlace'),
        actions: [
          TextButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home),
            label: const Text('Inicio'),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _familyCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nombre de la familia',
                          hintText: 'Ej. Familia López',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _countCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Cantidad de invitados',
                          hintText: 'Ej. 4',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          final n = int.tryParse(v?.trim() ?? '');
                          if (n == null || n <= 0) return 'Ingrese un número > 0';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: _generate,
                              icon: const Icon(Icons.link),
                              label: const Text('Generar enlace'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (_generatedUrl != null)
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SelectableText(
                            _generatedUrl!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              FilledButton.tonalIcon(
                                onPressed: _copyUrl,
                                icon: const Icon(Icons.copy),
                                label: const Text('Copiar'),
                              ),
                              OutlinedButton.icon(
                                onPressed: _openPreview,
                                icon: const Icon(Icons.open_in_new),
                                label: const Text('Abrir vista'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}