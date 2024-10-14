import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/reservation/reservation_bloc.dart';
import '../../bloc/reservation/reservation_event.dart';
import '../../bloc/reservation/reservation_state.dart';
import '../../models/models.dart';
import 'dart:developer' as dev;

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
                dev.log(reservationState.responseText.toString());
                final userReservations = reservationState.reservationList
                    .where((res) => res.userId == userState.user.id)
                    .toList();
                dev.log(userReservations.toString());
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
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room ${reservation.roomId}',
                  style: GoogleFonts.notoSansThai(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Table ${reservation.tableId}',
                  style: GoogleFonts.notoSansThai(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Duration: ${reservation.durationHours} hours',
                  style: GoogleFonts.notoSansThai(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Start: ${reservation.startTime}',
                  style: GoogleFonts.notoSansThai(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'End: ${reservation.endTime}',
                  style: GoogleFonts.notoSansThai(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${_getReservationStatus(reservation)}',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(reservation),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildCancelButton(reservation),
        ),
      ],
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
          context.read<TableBloc>().add(
                UpdateTableEvent(
                  tableId: reservation.tableId,
                  isAvailable: true,
                ),
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
