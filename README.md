# NubiaTech To-Do App

A simple To-Do app built with Flutter, using SQLite for local data storage and MobX for state management.

## Features

- Create new tasks
- Mark tasks as done
- Store tasks in SQLite database
- Manage state using MobX
- Delete Task (Long Press to delete)

## Technologies Used

- **Flutter:** UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **SQLite:** Local database for storing tasks persistently.
- **MobX:** State management library that makes it simple to connect the reactive data of your application with the UI.

## Project Structure

lutter_todo_app/
├── android
├── assets
├── build
├── ios
├── lib
│ ├── data_source
│ │ └── database_helper.dart
│ ├── models
│ │ └── task.dart
│ ├── stores
│ │ └── task_store.dart
│ ├── ui
│ │ ├── task_list.dart
│ │ └── task_form.dart
│ ├── main.dart
├── test
│ ├── database_helper_test.dart
│ └── task_store_test.dart
├── pubspec.yaml
└── README.md

## Getting Started

### Prerequisites

- Flutter installed on your machine
- Android Studio or Visual Studio Code for development

### Installing

1. **Clone the repository:**

```bash
git clone https://github.com/yourusername/flutter_todo_app.git
cd flutter_todo_app
```

1. **Install dependencies:**

flutter pub get

Run the app: flutter run
Run tests: flutter test

