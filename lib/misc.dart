// FUTURS - Miscellaneous functions
import 'package:flutter/material.dart';

// Set an icon regarding the category
Icon getIcon(category) {
  if (category == "tech") {
    return const Icon(Icons.computer);
  }
  else if (category == "health") {
    return const Icon(Icons.health_and_safety);
  }
  else {
    return const Icon(Icons.computer);
  }
}