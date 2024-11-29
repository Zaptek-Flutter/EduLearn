# Flutter Course Enrolling Application

This is a **Flutter-based Course Enrolling Application** that allows users to browse courses, enroll in them, and track their progress.

---

## Key Features

- **State Management**: Implemented using **Riverpod** for clean and efficient state management.
- **User Authentication**: Firebase Authentication enables secure user login and registration.
- **Local Service Model**: Populates the app with initial course content.
- **Course Enrollment**: Users can enroll in courses, which are added to the `my_courses` subcollection of their Firestore `users` document.
- **Progress Tracking**: Tracks progress for each enrolled course.

---

## Screenshots

### Splash screen
![App Splash screen](assets/screenshots/splash_screen.png)

### Sign up
![User Sign up](assets/screenshots/sign_up.png)

### Sign in
![User Sign in](assets/screenshots/sign_in.png)

### Home Screen
![Home Screen](assets/screenshots/home.png)

### Course Details
![Course Details](assets/screenshots/courses.png)

### My Courses
![My Courses](assets/screenshots/my-courses.png)

---

## Setup Instructions

1. Clone the repository:  
   ```bash
   git clone https://github.com/Zaptek-Flutter/EduLearn
   ```
2. Install dependencies:  
   ```bash
   flutter pub get
   ```
3. Configure Firebase for your project (update `google-services.json`).
4. Run the app:  
   ```bash
   flutter run
   ```

---

