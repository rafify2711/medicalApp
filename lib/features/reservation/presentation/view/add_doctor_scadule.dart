import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/reservation/data/models/add_update_schedule_response.dart';
import '../../../../core/utils/app_style.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../view_model/add_update_schedule_cubit.dart';
import '../view_model/add_update_schedule_state.dart';

class DoctorScheduleScreen extends StatefulWidget {
  @override
  _DoctorScheduleScreenState createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> with SingleTickerProviderStateMixin {
  DateTime selectedStartDate = DateTime.now();
  AddUpdateScheduleData addUpdateScheduleData = AddUpdateScheduleData(schedule: []);
  List<String> selectedTimeSlots = [];
  List<String> availableTimeSlots = [];
  late TabController _tabController;
  int currentDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentDayIndex = _tabController.index;
        selectedTimeSlots = [];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _generateTimeSlots() {
    availableTimeSlots = [];
    DateTime time = DateTime(2024, 1, 1, 8, 0); // Start at 8 AM
    DateTime endTime = DateTime(2024, 1, 1, 21, 0); // End at 9 PM

    while (time.isBefore(endTime)) {
      availableTimeSlots.add(_formatTimeOfDay(time));
      time = time.add(Duration(minutes: 30));
    }
  }

  String _formatTimeOfDay(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${hour12.toString().padLeft(2, '0')}:$minute $period';
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        selectedStartDate = pickedDate;
        selectedTimeSlots = [];
      });
    }
  }

  void _toggleTimeSlot(String timeSlot) {
    setState(() {
      if (selectedTimeSlots.contains(timeSlot)) {
        selectedTimeSlots.remove(timeSlot);
      } else {
        selectedTimeSlots.add(timeSlot);
      }
    });
  }

  void _addSchedule() {
    if (selectedTimeSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one time slot'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final date = selectedStartDate.add(Duration(days: currentDayIndex));
    final scheduleData = ScheduleData(
      date: date,
      timeSlots: selectedTimeSlots,
    );

    bool dateExists = false;
    for (var scheduleItem in addUpdateScheduleData.schedule) {
      if (_isSameDay(scheduleItem.date!, date)) {
        dateExists = true;
        scheduleItem.timeSlots = selectedTimeSlots;
        break;
      }
    }

    if (!dateExists) {
      addUpdateScheduleData.schedule.add(scheduleData);
    }

    setState(() {
      selectedTimeSlots = [];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Time slots added for ${_formatDate(date)}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getDayName(int index) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[index];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleCubit, ScheduleState>(
      listener: (context, state) {
        if (state is ScheduleLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        } else if (state is ScheduleSuccess) {
          Navigator.pop(context); // Remove loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Schedule saved successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        } else if (state is ScheduleError) {
          Navigator.pop(context); // Remove loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: MyAppPar(title: 'Add Schedule'),
        body: Column(
              children: [
                Card(
              margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                          color: AppColors.primary,
                              ),
                              SizedBox(width: 8),
                              Text(
                          'Week Starting: ${_formatDate(selectedStartDate)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Button(
                      onClick: () => _selectStartDate(context),
                      text: 'Change Week',
                          ),
                        ],
                      ),
                    ),
                  ),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.primary,
              tabs: List.generate(7, (index) {
                final date = selectedStartDate.add(Duration(days: index));
                return Tab(
                  child: Column(
                    children: [
                      Text(_getDayName(index)),
                      Text('${date.day}/${date.month}'),
                    ],
                  ),
                );
              }),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(7, (index) {
                  final date = selectedStartDate.add(Duration(days: index));
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Text(
                          'Time Slots for ${_formatDate(date)}',
                  style: TextStyle(
                            fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: availableTimeSlots.map((timeSlot) {
                            final isSelected = selectedTimeSlots.contains(timeSlot);
                            return GestureDetector(
                              onTap: () => _toggleTimeSlot(timeSlot),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected ? AppStyle.gradient : null,
                                  color: isSelected ? null : AppColors.primary1.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  timeSlot,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.white : AppColors.primary1,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 24),
                        Button(
                        onClick: _addSchedule,
                          text: 'Add Time Slots',
                      ),
                      ],
                    ),
                  );
                }),
              ),
                ),
                if (addUpdateScheduleData.schedule.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Current Schedule',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
              ),
                  Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: addUpdateScheduleData.schedule.length,
                      itemBuilder: (context, index) {
                        final scheduleItem = addUpdateScheduleData.schedule[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                        leading: Icon(
                                Icons.calendar_today,
                                color: AppColors.primary,
                            ),
                            title: Text(
                              _formatDate(scheduleItem.date!),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                        subtitle: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: scheduleItem.timeSlots.map((slot) {
                            return Chip(
                              label: Text(slot),
                              backgroundColor: AppColors.primary.withOpacity(0.1),
                              labelStyle: TextStyle(color: AppColors.primary),
                                  );
                                }).toList(),
                            ),
                            trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  addUpdateScheduleData.schedule.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
            Padding(
              padding: EdgeInsets.all(16),
              child: Button(
                  onClick: () async {
                    if (addUpdateScheduleData.schedule.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please add at least one schedule'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    final token = '';
                    final userId = '';

                    try {
                      await context.read<ScheduleCubit>().addUpdateSchedule(
                        userId,
                        token,
                        addUpdateScheduleData,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to save: ${e.toString()}'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  text: 'Save Schedule',
                ),
            ),
          ],
        ),
      ),
    );
  }
}