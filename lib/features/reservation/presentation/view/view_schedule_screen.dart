import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';
import '../../../../core/di/di.dart';
import '../view_model/schedule_cubit.dart';

class ViewScheduleScreen extends StatelessWidget {
  final String doctorId;
  final String token;

  const ViewScheduleScreen({Key? key, required this.doctorId, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ScheduleCubit>()..fetchSchedule(doctorId, token),
      child: BlocConsumer<ScheduleCubit, ScheduleState>(
        listener: (context, state) {
          if (state is ScheduleDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<ScheduleCubit>().fetchSchedule(doctorId, token);
          } else if (state is ScheduleDeleteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }else if (state is ScheduleDeleteLoading){
             Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary1),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: MyAppPar(title: AppLocalizations.of(context).mySchedule),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    Colors.white,
                  ],
                ),
              ),
              child: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ScheduleState state) {
    if (state is ScheduleLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary1),
        ),
      );
    }

    if (state is ScheduleError) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Button(
                onClick: () {
                  context.read<ScheduleCubit>().fetchSchedule(doctorId, token);
                },
                text: AppLocalizations.of(context).retry,
              ),
            ],
          ),
        ),
      );
    }

    if (state is ScheduleSuccess) {
      final schedule = state.schedule;
      if (schedule.isEmpty) {
        return _buildEmptyState(context);
      }
      final futureSchedules = _filterFutureSchedules(schedule);
      if (futureSchedules.isEmpty) {
        return _buildEmptyState(context);
      }
      return _buildScheduleList(context, futureSchedules);
    }

    return const Center(child: Text('Unknown state'));
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 64,
              color: AppColors.primary1.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).noScheduleAvailable,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primary1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Button(
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorScheduleScreen(),
                  ),
                );
              },
              text: AppLocalizations.of(context).addSchedule,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList(BuildContext context, List<dynamic> schedule) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: schedule.length,
            itemBuilder: (context, index) {
              final scheduleItem = schedule[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary1.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppColors.primary1,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatDate(scheduleItem.date!),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary1,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              final cubit = context.read<ScheduleCubit>();
                              _showDeleteConfirmationDialog(context, scheduleItem.date!, cubit);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (scheduleItem.timeSlots as List<String>)
                            .map((timeSlot) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary1.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    timeSlot,
                                    style: TextStyle(
                                      color: AppColors.primary1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Button(
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorScheduleScreen(),
                ),
              );
            },
            text: AppLocalizations.of(context).addMoreSlots,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, DateTime date, ScheduleCubit cubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).deleteSchedule),
          content: Text(AppLocalizations.of(context).deleteScheduleConfirmation),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                cubit.deleteSchedule(date);
              },
              child: Text(
                AppLocalizations.of(context).delete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  List<dynamic> _filterFutureSchedules(List<dynamic> schedules) {
    final now = DateTime.now();
    return schedules.where((schedule) {
      if (schedule.date == null) return false;
      final scheduleDate = schedule.date as DateTime;
      // Compare only the date part (year, month, day)
      return scheduleDate.year > now.year || 
             (scheduleDate.year == now.year && scheduleDate.month > now.month) ||
             (scheduleDate.year == now.year && scheduleDate.month == now.month && scheduleDate.day >= now.day);
    }).toList();
  }
} 