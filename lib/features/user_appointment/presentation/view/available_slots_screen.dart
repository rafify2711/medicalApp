import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart';
import '../../domain/use_cases/get_available_slots_use_case.dart';
import '../view_model/available_slots_cubit.dart';
import '../view_model/available_slots_state.dart';
class AvailableSlotsScreen extends StatelessWidget {

  final DateTime selectedDate;
  final String userId;

  AvailableSlotsScreen({required this.selectedDate, required this.userId});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create:  (context) => AvailableSlotsCubit(getIt<GetAvailableSlotsUseCase>()),
        child: BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
          builder: (context, state) {
            if (state is AvailableSlotsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AvailableSlotsErrorState) {
              return Center(child: Text(state.message));
            } else if (state is AvailableSlotsLoadedState) {
              return ListView.builder(
                itemCount: state.availableSlots.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(state.availableSlots[index]));
                },
              );
            }
            return Center(child: Text('No available slots'));
          },

    ));
  }
}
