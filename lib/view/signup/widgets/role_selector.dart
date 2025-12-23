import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import 'package:task/controllers/auth_controller.dart'; // يحتوي على UserRole

class RoleSelector extends StatelessWidget {
  final UserRole? selectedRole;
  final Function(UserRole) onSelect;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _roleCard(UserRole.owner, 'Owner', Icons.home_work_outlined),
        const SizedBox(width: 20),
        _roleCard(UserRole.tenant, 'Tenant', Icons.key_outlined),
      ],
    );
  }

  Widget _roleCard(UserRole role, String title, IconData icon) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => onSelect(role),
      child: Card(
        elevation: isSelected ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.darkTeal : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 40,
                  color:
                      isSelected ? AppColors.darkTeal : Colors.grey),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}