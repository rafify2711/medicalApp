import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/available_slots_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/models/appointment_model/reservation_data_model.dart';
import '../../view_model/available_slots_state.dart';
import '../../view_model/make_reservation_cubit.dart';
import '../../view_model/make_reservation_state.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/di/di.dart';

class MakeReservationScreen extends StatefulWidget {
  final String? doctorId;
  final DateTime? selectedDate;

  const MakeReservationScreen({
    Key? key,
    required this.doctorId,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _MakeReservationScreenState createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  String? _selectedTimeSlot;
  String _patientType = 'Yourself';
  String _gender = 'Male';
  final TextEditingController _nameController = TextEditingController(text: 'Jane Doe');
  final TextEditingController _ageController = TextEditingController(text: '30');
  final TextEditingController _problemController = TextEditingController();
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    if (widget.doctorId == null || widget.selectedDate == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Missing required information. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      });
    } else {
      _fetchAvailableSlots();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  void _fetchAvailableSlots() {
    if (widget.doctorId != null && widget.selectedDate != null) {
      final formattedDate = "${widget.selectedDate!.year}-${widget.selectedDate!.month.toString().padLeft(2, '0')}-${widget.selectedDate!.day.toString().padLeft(2, '0')}";
      context.read<AvailableSlotsCubit>().loadAvailableSlots(
        DateTime.parse(formattedDate),
        widget.doctorId!,
      );
    }
  }

  Future<void> _handleReservation() async {
    if (_isNavigating) return;

    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a time slot"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User not found. Please login again."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final formattedDate = "${widget.selectedDate!.year}-${widget.selectedDate!.month.toString().padLeft(2, '0')}-${widget.selectedDate!.day.toString().padLeft(2, '0')}";

    final reservationData = ReservationDataModel(
      doctorId: widget.doctorId!,
      userId: userId,
      date: DateTime.parse(formattedDate),
      timeSlot: _selectedTimeSlot!,
    );

    setState(() {
      _isNavigating = true;
    });

    try {
      await context.read<CreateReservationCubit>().createReservation(reservationData);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isNavigating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a Reservation"),
        backgroundColor: AppColors.primary1,
      ),
      body: BlocConsumer<CreateReservationCubit, CreateReservationState>(
        listener: (context, state) {
          if (!mounted) return;
          
          if (state is CreateReservationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Reservation successful"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, _selectedTimeSlot);
          } else if (state is CreateReservationError) {
            setState(() {
              _isNavigating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateReservationLoading || _isNavigating;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selected Date
                Text(
                  "Selected Date",
                  style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
                ),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.selectedDate != null
                        ? "${widget.selectedDate!.toLocal().toString().split(' ')[0]}"
                        : "No date selected",
                    style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary1),
                  ),
                ),
                SizedBox(height: 20),
                // Available Time
                Text(
                  "Available Time",
                  style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
                ),
                SizedBox(height: 10),
                BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
                  builder: (context, state) {
                    if (state is AvailableSlotsLoadingState) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            color: AppColors.primary1,
                          ),
                        ),
                      );
                    } else if (state is AvailableSlotsErrorState) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    } else if (state is AvailableSlotsLoadedState) {
                      if (state.availableSlots.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "No available slots for this date",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: state.availableSlots.map((slot) {
                          final isSelected = _selectedTimeSlot == slot;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTimeSlot = slot;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: isSelected ? AppStyle.gradient : null,
                                color: isSelected ? null : AppColors.primary1.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(
                                slot,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppColors.primary1,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "No available slots",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24),
                // Patient Details
                Text(
                  "Patient Details",
                  style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildToggleButton("Yourself", _patientType == 'Yourself', () {
                      setState(() => _patientType = 'Yourself');
                    }),
                    SizedBox(width: 10),
                    _buildToggleButton("Another Person", _patientType == 'Another Person', () {
                      setState(() => _patientType = 'Another Person');
                    }),
                  ],
                ),
                SizedBox(height: 16),
                // Full Name
                _buildTextField(_nameController, "Full Name"),
                SizedBox(height: 12),
                // Age
                _buildTextField(_ageController, "Age", keyboardType: TextInputType.number),
                SizedBox(height: 12),
                // Gender
                Text("Gender", style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary1)),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildToggleButton("Male", _gender == 'Male', () {
                      setState(() => _gender = 'Male');
                    }),
                    SizedBox(width: 10),
                    _buildToggleButton("Female", _gender == 'Female', () {
                      setState(() => _gender = 'Female');
                    }),
                    SizedBox(width: 10),
                    _buildToggleButton("Other", _gender == 'Other', () {
                      setState(() => _gender = 'Other');
                    }),
                  ],
                ),
                SizedBox(height: 18),
                // Problem Description
                Text("Describe your problem", style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary1)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _problemController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter Your Problem Here...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: AppColors.primary1,
                        )
                      : ElevatedButton(
                          onPressed: _handleReservation,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            backgroundColor: AppColors.primary1,
                          ),
                          child: Text(
                            "Make Reservation",
                            style: AppStyle.bodyWhiteTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggleButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected ? AppStyle.gradient : null,
          color: selected ? null : AppColors.primary1.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.primary1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary1.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
