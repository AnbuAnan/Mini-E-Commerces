import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:  const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.teal,
        ),
        onPressed: loading ? null : onPressed, 
        child: 
        loading ?
        const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),)
        : Text(label,style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),)
        ),
    );
  }
}
