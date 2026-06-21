import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';

class CreateLocationDialog extends StatefulWidget {
  final ApiService apiService;

  const CreateLocationDialog({super.key, required this.apiService});

  @override
  State<CreateLocationDialog> createState() => _CreateLocationDialogState();
}

class _CreateLocationDialogState extends State<CreateLocationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _glnController = TextEditingController();
  String _selectedType = 'FIELD';
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _glnController.dispose();
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
        'gln': _glnController.text.trim().isNotEmpty ? _glnController.text.trim() : null,
        'geoJsonPolygon': '{"type": "Polygon", "coordinates": [[[0,0],[0,1],[1,1],[1,0],[0,0]]]}', // dummyGeoJson
      };

      final created = await widget.apiService.createLocation(payload);
      if (mounted) {
        Navigator.pop(context, created);
      }
    } catch (e) {
      setState(() {
        _isSaving = false;
        _error = 'Failed to create plot: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: const Text('Add Field / Plot', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  labelText: 'Plot Name *',
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
                  DropdownMenuItem(value: 'FIELD', child: Text('Field / Plot')),
                  DropdownMenuItem(value: 'FACILITY', child: Text('Facility / Barn')),
                ],
                onChanged: _isSaving ? null : (val) => setState(() => _selectedType = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _glnController,
                decoration: const InputDecoration(
                  labelText: 'GS1 GLN (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g. 5012345678900',
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
