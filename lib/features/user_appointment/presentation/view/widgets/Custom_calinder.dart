import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;

  const CustomCalendar({
    Key? key,
    this.onDateSelected,
    this.initialDate,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  final List<String> _weekDays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  List<DateTime> _getDaysInMonth() {
    final List<DateTime> days = [];
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    // Add empty slots for days before the first day of month
    int firstWeekday = firstDayOfMonth.weekday;
    for (int i = 1; i < firstWeekday; i++) {
      days.add(firstDayOfMonth.subtract(Duration(days: firstWeekday - i)));
    }

    // Add all days of the month
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    // Add remaining days to complete the last week
    int remainingDays = 7 - (days.length % 7);
    if (remainingDays < 7) {
      for (int i = 1; i <= remainingDays; i++) {
        days.add(lastDayOfMonth.add(Duration(days: i)));
      }
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              PopupMenuButton<int>(
                child: Row(
                  children: [
                    Text(
                      _months[_currentMonth.month - 1],
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  ],
                ),
                onSelected: (int month) {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, month + 1);
                  });
                },
                itemBuilder: (BuildContext context) {
                  return List.generate(12, (index) {
                    return PopupMenuItem(
                      value: index,
                      child: Text(_months[index]),
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekDays.map((day) => Container(
              width: 40,
              child: Text(
                day,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            )).toList(),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: _getDaysInMonth().length,
            itemBuilder: (context, index) {
              final date = _getDaysInMonth()[index];
              final isCurrentMonth = date.month == _currentMonth.month;
              final isSelected = date.year == _selectedDate.year &&
                  date.month == _selectedDate.month &&
                  date.day == _selectedDate.day;

              return GestureDetector(
                onTap: () {
                  if (isCurrentMonth) {
                    setState(() {
                      _selectedDate = date;
                    });
                    if (widget.onDateSelected != null) {
                      widget.onDateSelected!(date);
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: !isCurrentMonth
                            ? Colors.grey
                            : isSelected
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}