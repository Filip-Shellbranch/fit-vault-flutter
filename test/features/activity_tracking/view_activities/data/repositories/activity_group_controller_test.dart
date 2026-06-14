import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_group_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ActivityGroupController controller;
  setUp(() {
    controller = ActivityGroupController();
  });

  group("Calculate display group", () {
    test("test calculate group 'This week'", () {
      final today = DateTime(2026, 6, 6);
      final tuesdayThisWeek = DateTime(2026, 6, 2);
      expect(
        controller.calculateGroup(tuesdayThisWeek, today),
        ActivityGroup.thisWeek,
      );
      final fridayThisWeek = DateTime(2026, 6, 5);
      expect(
        controller.calculateGroup(fridayThisWeek, today),
        ActivityGroup.thisWeek,
      );
      final sundayThisWeek = DateTime(2026, 6, 7);
      expect(
        controller.calculateGroup(sundayThisWeek, today),
        ActivityGroup.thisWeek,
      );
    });

    test("test calculate group 'Last week'", () {
      final today = DateTime(2026, 6, 13);
      final tuesdayLastWeek = DateTime(2026, 6, 2);
      expect(
        controller.calculateGroup(tuesdayLastWeek, today),
        ActivityGroup.lastWeek,
      );
      final fridayThisWeek = DateTime(2026, 6, 5);
      expect(
        controller.calculateGroup(fridayThisWeek, today),
        ActivityGroup.lastWeek,
      );
      final sundayThisWeek = DateTime(2026, 6, 7);
      expect(
        controller.calculateGroup(sundayThisWeek, today),
        ActivityGroup.lastWeek,
      );
    });
    test("test calculate group 'Earlier'", () {
      final today = DateTime(2026, 6, 13);
      final tuesdayTwoWeeksAgo = DateTime(2026, 5, 26);
      expect(
        controller.calculateGroup(tuesdayTwoWeeksAgo, today),
        ActivityGroup.earlier,
      );
      final lastYear = DateTime(2025, 6, 5);
      expect(controller.calculateGroup(lastYear, today), ActivityGroup.earlier);
    });
  });
}
