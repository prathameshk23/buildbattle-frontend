import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/user_profile.dart';

final profileProvider = Provider<UserProfile>(
  (ref) => UserProfile.sample().copyWith(onboardingComplete: true),
);
