import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';

class CreateProductDialog extends StatefulWidget {
  final ApiService apiService;

  const CreateProductDialog({super.key, required this.apiService});

  @override
  State<CreateProductDialog> createState() => _CreateProductDialogState();
}

class _CreateProductDialogState extends State<CreateProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gtinController = TextEditingController();
  final _varietyController = TextEditingController();
  String _selectedType = 'CROP';
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _gtinController.dispose();
    _varietyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final payload = {
        'name': _nameController.text.trim(),
        'type': _selectedType,
        'gtin': _gtinController.text.trim(),
        'variety': _varietyController.text.trim().isNotEmpty ? _varietyController.text.trim() : null,
      };

      final created = await widget.apiService.createProduct(payload);
      if (mounted) {
        Navigator.pop(context, created);
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
        _error = 'Failed to create crop: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: const Text('Add Crop / Product', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[
                Text(
                  _error!,
                  style: TextStyle(color: colorScheme.error, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Name is required' : null,
                enabled: !_isSaving,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type *',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'CROP', child: Text('Crop (Harvestable)')),
                  DropdownMenuItem(value: 'PESTICIDE', child: Text('Pesticide')),
                  DropdownMenuItem(value: 'FERTILIZER', child: Text('Fertilizer')),
                ],
                onChanged: _isSaving ? null : (val) => setState(() => _selectedType = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gtinController,
                decoration: const InputDecoration(
                  labelText: 'GS1 GTIN *',
                  border: OutlineInputBorder(),
                  hintText: '8 to 14 digits',
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'GTIN is required';
                  if (!RegExp(r'^\d{8,14}$').hasMatch(val.trim())) {
                    return 'GTIN must be a numeric string between 8 and 14 digits';
                  }
                  return null;
                },
                enabled: !_isSaving,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _varietyController,
                decoration: const InputDecoration(
                  labelText: 'Variety (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. Honeycrisp',
                ),
                enabled: !_isSaving,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _submit,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: _isSaving
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
