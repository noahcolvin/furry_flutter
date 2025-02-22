# Furry - Flutter
This is a sample mobile app named `Furry`, a (very) basic pet store. This is not intended to be a complete application, but rather a starting point for a full application.

Created using Flutter and Riverpod.

## Features
- Dashboard page
- List of store items with filtering
- Item detail page
- Cart page
- Item search

## Screenshots
#### Android
![Dashboard](screenshots/Android/Dashboard.png)
![Item Detail](screenshots/Android/ItemDetails.png)
![Store](screenshots/Android/Store.png)
![Cart](screenshots/Android/Cart.png)

#### Android
![Dashboard](screenshots/iOS/Dashboard.png)
![Item Detail](screenshots/iOS/ItemDetails.png)
![Store](screenshots/iOS/Store.png)
![Cart](screenshots/iOS/Cart.png)

## How to run
[Install Flutter](https://docs.flutter.dev/get-started/install) for your platform of choice.

The backend is not included in this repository. That will be available separately.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Running Tests
```bash
flutter test
```

## Questions
#### What is the purpose of this project?
I created this project to demonstrate creating a simple mobile app in Flutter.

I made one in [Android](https://github.com/noahcolvin/furry-android) and [React Native](https://github.com/noahcolvin/furry-rn) too!

#### Why isn't there much here?
This is just a starting point. I wanted to keep it simple and not include too many features. This is a good starting point for a full application.

#### This isn't very pretty
Sure, but also I'm not a designer. Rest assured, I will not be taking any design jobs.

#### Where is the backend?
There are a few, currently:

[Supabase/Node](https://github.com/noahcolvin/furry-backend)

[.NET](https://github.com/noahcolvin/furry-backend-dotnet)

[Express/Node](https://github.com/noahcolvin/furry-backend-express)

#### Why is there no authentication?
No need for the current app.

#### Code X is bad, why didn't you do Y?
This is just a sample exercise and was completed in a few days. I'm sure there are many improvements that could be made. Fell free to make an issue or PR if you have a suggestion. This doesn't need to be perfect but I am certainly open to feedback. I may add to it in the future.