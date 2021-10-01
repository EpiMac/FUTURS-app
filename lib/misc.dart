// FUTURS - Miscellaneous functions
import 'package:flutter/material.dart';

// Set an icon regarding the category
Icon getIcon(category) {
  if (category == "tech") { // Tech
    return const Icon(Icons.computer);
  }
  else if (category == "health") { // Santé
    return const Icon(Icons.health_and_safety);
  }
  else if (category == "sport") { // Sport
    return const Icon(Icons.sports_baseball);
  }
  else if (category == "arvr") { // AR/VR
    return const Icon(Icons.view_in_ar);
  }
  else if (category == "comfort") { // Bien être
    return const Icon(Icons.volunteer_activism);
  }
  else if (category == "robotic") { // Robotique
    return const Icon(Icons.smart_toy);
  }
  else if (category == "food") { // Nourriture
    return const Icon(Icons.restaurant);
  }
  else if (category == "events") { // Évènements
    return const Icon(Icons.calendar_today);
  }
  else if (category == "artdesign") { // Art & Design
    return const Icon(Icons.theater_comedy);
  }
  else if (category == "fashion") { // Fashion
    return const Icon(Icons.umbrella);
  }
  else if (category == "video") { // Vidéo
    return const Icon(Icons.videocam);
  }
  else if (category == "work") { // Travail
    return const Icon(Icons.store);
  }
  else if (category == "sextech") { // SexTech
    return const Icon(Icons.whatshot);
  }
  else { // Other
    return const Icon(Icons.wallpaper);
  }
}