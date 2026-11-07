import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/my_registration/my_registration_bloc.dart';
import 'package:football_app/bloc/my_registration/my_registration_event.dart';
import 'package:football_app/bloc/my_registration/my_registration_state.dart';
import 'package:football_app/model/my_registration/my_registration_model.dart';
import 'package:football_app/view/my_registration/widgets/registration_cards_widget.dart';
import 'package:football_app/view/my_registration/widgets/registration_details_bottom_sheet_widget.dart';

enum RegistrationFilter { all, upcoming, completed }

class MyRegistrationScreen extends StatefulWidget {
  const MyRegistrationScreen({super.key});

  @override
  State<MyRegistrationScreen> createState() => _MyRegistrationScreenState();
}

class _MyRegistrationScreenState extends State<MyRegistrationScreen> {
  RegistrationFilter selectedFilter = RegistrationFilter.all;

  @override
  void initState() {
    super.initState();

    context.read<MyRegistrationBloc>().add(
      const RegistrationEvent.loadRegistrations(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0B0D),
        elevation: 0,
        title: const Text(
          'My Registrations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildFilters(),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<MyRegistrationBloc, RegistrationState>(
              builder: (context, state) {
                return switch (state) {
                  RegistrationInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  RegistrationLoading() => const Center(
                    child: CircularProgressIndicator(color: Color(0xFFB6F36B)),
                  ),
                  RegistrationLoaded(:final registrations) =>
                    _buildRegistrationList(registrations),
                  RegistrationError(:final message) => _buildError(message),
                  // TODO: Handle this case.
                  RegistrationState() => throw UnimplementedError(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: RegistrationFilter.values.map((filter) {
          final isSelected = selectedFilter == filter;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFB6F36B)
                      : const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  filter.name[0].toUpperCase() + filter.name.substring(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRegistrationList(List<MyRegistrationModel> registrations) {
    final now = DateTime.now();

    final filteredRegistrations = registrations.where((registration) {
      final isUpcoming = registration.tournamentDate.isAfter(now);

      switch (selectedFilter) {
        case RegistrationFilter.all:
          return true;
        case RegistrationFilter.upcoming:
          return isUpcoming;
        case RegistrationFilter.completed:
          return !isUpcoming;
      }
    }).toList();

    if (filteredRegistrations.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      color: const Color(0xFFB6F36B),
      backgroundColor: const Color(0xFF1C1C1E),
      onRefresh: () async {
        context.read<MyRegistrationBloc>().add(
          const RegistrationEvent.loadRegistrations(),
        );
      },
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: filteredRegistrations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final registration = filteredRegistrations[index];

          return RegistrationCard(
            registration: registration,
            onTap: () => _showDetails(registration),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 100),
        Icon(Icons.sports_soccer_outlined, color: Colors.white38, size: 65),
        SizedBox(height: 18),
        Text(
          'No registrations found',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Your tournament registrations will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 45),
            const SizedBox(height: 12),
            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                context.read<MyRegistrationBloc>().add(
                  const RegistrationEvent.loadRegistrations(),
                );
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetails(MyRegistrationModel registration) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return RegistrationDetails(registration: registration);
      },
    );
  }
}
