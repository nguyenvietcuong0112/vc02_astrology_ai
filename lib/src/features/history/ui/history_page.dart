import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myapp/src/features/history/services/database_helper.dart';
import 'package:myapp/src/features/horoscope/ui/horoscope_result_card.dart';

import '../../../../l10n/app_localizations.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _horoscopesFuture;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _refreshHoroscopes();
  }

  void _refreshHoroscopes() {
    setState(() {
      _horoscopesFuture = dbHelper.getHoroscopes();
    });
  }

  void _showHoroscopeDetails(BuildContext context, Map<String, dynamic> horoscope) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        builder: (_, scrollController) {
          return HistoryDetailSheet(
            horoscope: horoscope,
            scrollController: scrollController,
            onNoteSaved: _refreshHoroscopes, // Refresh list after saving a note
          );
        },
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp).toLocal();
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } catch (e) {
      developer.log('Error formatting timestamp: $timestamp', error: e);
      return 'Ngày không xác định';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _horoscopesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            developer.log('Error loading horoscopes', error: snapshot.error);
            return Center(child: Text(l10n.errorHistory));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(l10n.noHistory));
          }

          final horoscopes = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async => _refreshHoroscopes(),
            child: ListView.builder(
              itemCount: horoscopes.length,
              itemBuilder: (context, index) {
                final horoscope = horoscopes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(
                        '${horoscope['date']} - ${horoscope['time']}'),
                    subtitle: Text('${l10n.atLabel}: ${horoscope['place']}\n${l10n.viewedOnLabel}: ${_formatTimestamp(horoscope['createdAt'])}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showHoroscopeDetails(context, horoscope),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- History Detail Sheet ---
class HistoryDetailSheet extends StatefulWidget {
  final Map<String, dynamic> horoscope;
  final ScrollController scrollController;
  final VoidCallback onNoteSaved;

  const HistoryDetailSheet({
    super.key,
    required this.horoscope,
    required this.scrollController,
    required this.onNoteSaved,
  });

  @override
  State<HistoryDetailSheet> createState() => _HistoryDetailSheetState();
}

class _HistoryDetailSheetState extends State<HistoryDetailSheet> {
  late final Map<String, dynamic> _horoscopeData;
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Make a mutable copy
    _horoscopeData = Map<String, dynamic>.from(widget.horoscope);
  }

  Future<void> _editNote(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final noteController = TextEditingController(text: _horoscopeData['notes'] as String?);

    final newNote = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editNote),
        content: TextField(
          controller: noteController,
          autofocus: true,
          maxLines: 5,
          decoration: InputDecoration(hintText: l10n.noteHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, noteController.text);
            },
            child: Text(l10n.saveButton),
          ),
        ],
      ),
    );

    if (newNote != null) {
      await dbHelper.updateHoroscopeNotes(_horoscopeData['id'], newNote);
      setState(() {
        _horoscopeData['notes'] = newNote;
      });
      widget.onNoteSaved(); // Notify the parent to refresh
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final result = jsonDecode(_horoscopeData['result']);
    final notes = _horoscopeData['notes'] as String?;

    return ListView(
      controller: widget.scrollController,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: HoroscopeResultCard(result: result),
        ),
        const Divider(height: 30, thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.personalNotes,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_note_outlined),
                    onPressed: () => _editNote(context),
                    tooltip: l10n.editNote,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              (notes == null || notes.isEmpty)
                  ? Text(
                      l10n.noNotesYet,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                    )
                  : Text(
                      notes,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(height: 1.5),
                    ),
              const SizedBox(height: 40),
            ],
          ),
        )
      ],
    );
  }
}
