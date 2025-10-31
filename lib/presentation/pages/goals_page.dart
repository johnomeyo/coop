import 'package:coop/presentation/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double kDesktopBreakpoint = 900;

class GoalModel {
  final String id;
  final String title;
  final double target;
  final double achieved;
  final DateTime createdAt;

  GoalModel({
    required this.id,
    required this.title,
    required this.target,
    required this.achieved,
    required this.createdAt,
  });

  double get progress => (achieved / target).clamp(0.0, 1.0);
  double get remainingAmount => target - achieved;
  int get percentComplete => (progress * 100).toInt();
}

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final List<GoalModel> _goals = [];

  void _addGoal(GoalModel goal) {
    setState(() {
      _goals.add(goal);
    });
  }

  void _deleteGoal(String id) {
    setState(() {
      _goals.removeWhere((goal) => goal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= kDesktopBreakpoint;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGoalDialog(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text("New Goal"),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isDesktop) {
              return Row(
                children: [
                  // const SizedBox(width: 260, child: SideMenu(currentPage: 'Goals',)),
                  Expanded(
                    child: _buildContent(),
                  ),
                ],
              );
            } else {
              return _buildContent();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return _goals.isEmpty
        ? GoalsEmptyState(onAddGoal: () => _showAddGoalDialog(context))
        : GoalsGridView(
            goals: _goals,
            isDesktop: MediaQuery.of(context).size.width >= kDesktopBreakpoint,
            onDeleteGoal: _deleteGoal,
          );
  }

  void _showAddGoalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddGoalDialog(
        onGoalCreated: _addGoal,
      ),
    );
  }
}

class AddGoalDialog extends StatefulWidget {
  final Function(GoalModel) onGoalCreated;

  const AddGoalDialog({
    super.key,
    required this.onGoalCreated,
  });

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _targetController;
  late TextEditingController _achievedController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _targetController = TextEditingController();
    _achievedController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    _achievedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "Create New Goal",
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              _buildTextField(
                controller: _titleController,
                label: "Goal Title",
                hint: "e.g., Save for vacation",
                validator: (value) =>
                    value?.isEmpty ?? true ? "Please enter a title" : null,
              ),
              _buildTextField(
                controller: _targetController,
                label: "Target Amount (KES)",
                hint: "e.g., 50000",
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty ?? true
                    ? "Please enter a target amount"
                    : null,
              ),
              _buildTextField(
                controller: _achievedController,
                label: "Achieved Amount (KES)",
                hint: "e.g., 10000",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if ((value?.isEmpty ?? true)) return null;
                  final achieved = double.tryParse(value!);
                  final target = double.tryParse(_targetController.text);
                  if (achieved != null && target != null && achieved > target) {
                    return "Achieved amount cannot exceed target";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: _submitForm,
          child: const Text("Create Goal"),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final goal = GoalModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        target: double.parse(_targetController.text),
        achieved: double.tryParse(_achievedController.text) ?? 0.0,
        createdAt: DateTime.now(),
      );

      widget.onGoalCreated(goal);
      Navigator.pop(context);
    }
  }
}

class GoalsGridView extends StatelessWidget {
  final List<GoalModel> goals;
  final bool isDesktop;
  final Function(String) onDeleteGoal;

  const GoalsGridView({
    super.key,
    required this.goals,
    required this.isDesktop,
    required this.onDeleteGoal,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Goals",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Track your progress and achieve your targets",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: goals.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 1,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isDesktop ? 1.3 : 1.6,
            ),
            itemBuilder: (context, index) {
              return GoalCard(
                goal: goals[index],
                onDelete: () => onDeleteGoal(goals[index].id),
              );
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final VoidCallback onDelete;

  const GoalCard({
    super.key,
    required this.goal,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    goal.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final colors = Theme.of(context).colorScheme;

                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: const Text(
                            "Confirm Deletion",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Are you sure you want to delete this item?",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          actionsPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          actions: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                side: BorderSide(color: colors.outline),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: colors.error,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: onDelete,
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: theme.colorScheme.error,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GoalProgressIndicator(goal: goal),
            const SizedBox(height: 16),
            GoalStats(goal: goal),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat('MMM d, yyyy').format(goal.createdAt),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalProgressIndicator extends StatelessWidget {
  final GoalModel goal;

  const GoalProgressIndicator({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Progress",
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${goal.percentComplete}%",
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: goal.progress,
            minHeight: 10,
            backgroundColor: primaryColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
      ],
    );
  }
}

class GoalStats extends StatelessWidget {
  final GoalModel goal;

  const GoalStats({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(
            label: "Achieved",
            value: "KES ${goal.achieved.toStringAsFixed(0)}",
            theme: theme,
          ),
          Container(
            width: 1,
            height: 30,
            color: theme.colorScheme.outlineVariant,
          ),
          _buildStatItem(
            label: "Remaining",
            value: "KES ${goal.remainingAmount.toStringAsFixed(0)}",
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class GoalsEmptyState extends StatelessWidget {
  final VoidCallback onAddGoal;

  const GoalsEmptyState({
    super.key,
    required this.onAddGoal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/goals_png.png",
              height: 150,
            ),
            const SizedBox(height: 24),
            Text(
              "No Goals Yet",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Start tracking your financial goals and watch your progress grow.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: onAddGoal,
              child: const Text("Create Your First Goal"),
            ),
          ],
        ),
      ),
    );
  }
}
