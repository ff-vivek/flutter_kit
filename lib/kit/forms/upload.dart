import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Simple picked file model independent of file_picker types
class UkPickedFile {
  UkPickedFile({required this.name, required this.size, this.bytes, this.extension});
  final String name;
  final int size;
  final Uint8List? bytes;
  final String? extension;
}

/// UkUpload
/// A modern, minimal file picker with an optional drop-zone look.
class UkUpload extends StatefulWidget {
  const UkUpload({
    super.key,
    this.allowMultiple = false,
    this.allowedExtensions,
    required this.onFilesSelected,
    this.label = 'Choose files…',
    this.hint,
  });

  final bool allowMultiple;
  final List<String>? allowedExtensions;
  final ValueChanged<List<UkPickedFile>> onFilesSelected;
  final String label;
  final String? hint;

  @override
  State<UkUpload> createState() => _UkUploadState();
}

class _UkUploadState extends State<UkUpload> {
  bool _loading = false;
  String? _error;

  Future<void> _pick() async {
    setState(() => _loading = true);
    try {
      final res = await FilePicker.platform.pickFiles(
        allowMultiple: widget.allowMultiple,
        withData: true,
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: widget.allowedExtensions,
      );
      final files = <UkPickedFile>[];
      if (res != null) {
        for (final f in res.files) {
          files.add(UkPickedFile(
            name: f.name,
            size: f.size,
            bytes: f.bytes,
            extension: f.extension,
          ));
        }
      }
      widget.onFilesSelected(files);
      setState(() => _error = null);
    } catch (e, st) {
      debugPrint('UkUpload pick error: $e\n$st');
      setState(() => _error = 'Failed to select files');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_upload_outlined, color: cs.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.label, style: Theme.of(context).textTheme.titleSmall),
                if (widget.hint != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(widget.hint!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                  ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(_error!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.error)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.tonal(
            onPressed: _loading ? null : _pick,
            child: Row(children: [
              if (_loading) ...[
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: cs.primary),
                ),
                const SizedBox(width: 8),
              ],
              const Text('Browse'),
            ]),
          ),
        ],
      ),
    );
  }
}
