import 'dart:collection';

import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';

HashMap<int, NetguruValueModel> coreValues = HashMap.of({
  1: const NetguruValueModel(
    id: 1,
    text: "Exceed clients' and colleagues' expectations",
    isDefault: true,
  ),
  2: const NetguruValueModel(
    id: 2,
    text: "Take ownership and question the status quo in a constructive manner",
    isDefault: true,
  ),
  3: const NetguruValueModel(
    id: 3,
    text:
        "Be brave, curious and experiment. Learn from all successes and failures",
    isDefault: true,
  ),
  4: const NetguruValueModel(
    id: 4,
    text: "Act in a way that makes all of us proud",
    isDefault: true,
  ),
  5: const NetguruValueModel(
    id: 5,
    text: "Build an inclusive, transparent and socially responsible culture",
    isDefault: true,
  ),
  6: const NetguruValueModel(
    id: 6,
    text: "Be ambitious, grow yourself and the people around you",
    isDefault: true,
  ),
  7: const NetguruValueModel(
    id: 7,
    text: "Recognize excellence and engagement",
    isDefault: true,
  ),
});
