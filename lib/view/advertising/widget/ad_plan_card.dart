import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/model/ad_plan_model.dart';

import '../../../core/LoginResponce/global_user.dart';

class PlanCard extends StatefulWidget {
  final AdsPlanModel plan;
  final VoidCallback? onEdit;

  const PlanCard({
    super.key,
    required this.plan,
    this.onEdit,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1.0, end: _hovering ? 1.03 : 1.0),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: _hovering ? 16 : 6,
                offset: Offset(0, _hovering ? 10 : 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  
                    Row(
                      children: [
                        if (plan.badge != null && plan.badge!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            plan.badge!,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                     GlobalUser().currentUser!.admin.roles.adsPlanEdit == true?    IconButton(onPressed: widget.onEdit, icon: const Icon(Icons.edit_note_sharp, color: Color.fromARGB(202, 50, 154, 239))):SizedBox(),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${plan.minViews} - ${plan.maxViews} Views',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                plan.description??'',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${plan.originalPrice}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    '\$${plan.offerPrice}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
