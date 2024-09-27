# My Code - Flutter Firebase Project

This project is a Flutter application that allows users to create and view code snippets using Firebase as a backend.

## Features

- View a list of code snippets
- Add new code snippets
- Real-time updates using Firebase Firestore

## Prerequisites

Before you begin, ensure you have met the following requirements:
* You have installed the latest version of [Flutter](https://flutter.dev/docs/get-started/install)
* You have a Firebase account and have set up a new project

## Installing My Code

To install My Code, follow these steps:

1. Clone the repository
   ```
   git clone https://github.com/H-djivandjy/flutterFirebaseTp.git
   ```
2. Navigate to the project directory
   ```
   cd flutterFirebaseTp
   ```
3. Get the dependencies
   ```
   flutter pub get
   ```

## Configuring Firebase

1. Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/)
2. Add a new web app to your Firebase project
3. Copy the Firebase configuration from the Firebase Console
4. Update the `firebase_options.dart` file with your Firebase configuration

## Running My Code

To run My Code, follow these steps:

```
flutter run -d chrome
```

Note: This project is currently configured for web. To run on other platforms, you'll need to configure Firebase for those platforms using the FlutterFire CLI.

## Contributing to My Code

To contribute to My Code, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin <project_name>/<location>`
5. Create the pull request.

Alternatively, see the GitHub documentation on [creating a pull request](https://help.github.com/articles/creating-a-pull-request/).


## License

This project is free to use for educational purposes.