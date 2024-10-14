import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/reservation/reservation_bloc.dart';
import '../../bloc/reservation/reservation_event.dart';
import '../../bloc/reservation/reservation_state.dart';
import '../../models/models.dart';

class BodyReservation extends StatefulWidget {
  const BodyReservation({super.key});

  @override
  BodyReservationState createState() => BodyReservationState();
}

class BodyReservationState extends State<BodyReservation> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is ReadyUserState) {
          return BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, reservationState) {
              if (reservationState is ReadyReservationState) {
                final userReservations = reservationState.reservationList
                    .where((res) => res.userId == userState.user.id)
                    .toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: userReservations.length,
                    itemBuilder: (context, index) {
                      final reservation = userReservations[index];
                      return _buildReservationCard(reservation);
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        return const Center(
            child: Text('Please log in to view your reservations'));
      },
    );
  }

  Widget _buildReservationCard(ReservationModel reservation) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          'Table ${reservation.tableId} in Room ${reservation.roomId}',
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Duration: ${reservation.durationHours} hours',
              style: GoogleFonts.notoSansThai(fontSize: 16),
            ),
            Text(
              'Start Time: ${reservation.startTime}',
              style: GoogleFonts.notoSansThai(fontSize: 16),
            ),
            Text(
              'End Time: ${reservation.endTime}',
              style: GoogleFonts.notoSansThai(fontSize: 16),
            ),
            Text(
              'Status: ${_getReservationStatus(reservation)}',
              style: GoogleFonts.notoSansThai(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getStatusColor(reservation),
              ),
            ),
          ],
        ),
        trailing: _buildCancelButton(reservation),
      ),
    );
  }

  String _getReservationStatus(ReservationModel reservation) {
    final now = DateTime.now();
    final startTime = DateTime.parse(reservation.startTime);
    final endTime = DateTime.parse(reservation.endTime);

    if (now.isBefore(startTime)) {
      return 'Upcoming';
    } else if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return 'Active';
    } else {
      return 'Completed';
    }
  }

  Color _getStatusColor(ReservationModel reservation) {
    switch (_getReservationStatus(reservation)) {
      case 'Upcoming':
        return Colors.blue;
      case 'Active':
        return Colors.green;
      case 'Completed':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  Widget _buildCancelButton(ReservationModel reservation) {
    if (_getReservationStatus(reservation) == 'Upcoming') {
      return ElevatedButton(
        onPressed: () {
          context.read<ReservationBloc>().add(
                DeleteReservationEvent(reservationId: reservation.id),
              );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Text(
          'Cancel',
          style: GoogleFonts.notoSansThai(color: Colors.white),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
