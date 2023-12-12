
# Weather Assignment

A  Flutter mobile app that fetches and displays current weather information for a given location.



## Prerequisites

 - Flutter SDK
 - Dart SDK
 - IDE (Android Studio, IntelliJ IDEA, VS Code, Xcode)


## How to Run

There are 2 way to deploy this project run

- First way: Navigate into project folder/scripts and run clean.sh file.

- Second way: Run 2 command

```bash
  dart run build_runner build --delete-conflicting-outputs
```


```bash
  dart run intl_utils:generate 
```




## Project structure

There are 3 main folder:

- Common Directory:
    - `constants`: For constant values used throughout the project.
    - `enums`: For enum types.
    - `extensions`: For Dart language extensions.
    - `theme`: For styling and theming configurations.
    - `utils`: For app environment, commonly used components.
    - `widgets`: For commonly used widgets.        

- Core Directory:
    - `datasources`: For API-related and local data conversation.
    - `interfaces`: For Dart interfaces.
    - `models`: For data models.
    - `repositories`: For data repositories or service classes.

- Modules Directory:
    - `app_router`: for app routing.
    - Each screen has its own directory.
    - `page`: For screen-specific routing.
    - `widget`: For screen-specific UI components.
    - `application`: For the Cubit/bloc file associated with the screen.
    
## Features

- Switch between location and longitude/latitude input toggle
- Show weather of city when input (have a 300ms debounce)
- Check if input is correct




## Major Dependencies
The project utilizes several external dependencies to enhance functionality and streamline development. Below are the major dependencies used:

- **Bloc:**  [Bloc](https://pub.dev/packages/bloc) is a state management library for Flutter that helps in managing and organizing the state of your application.

- **Auto Route:**  [Auto Route](https://pub.dev/packages/auto_route) is a declarative routing package for Flutter that generates route helpers directly from your route configuration.

- **GetIt:** [GetIt](https://pub.dev/packages/get_it) is a simple service locator for Dart and Flutter projects. It provides a convenient way to obtain instances of objects and services.

- **Dio:**  [Dio](https://pub.dev/packages/dio) is a powerful HTTP client for Dart, which simplifies making HTTP requests and working with REST APIs.

- **Freezed Annotation:** [Freezed Annotation](https://pub.dev/packages/freezed_annotation) is part of the Freezed package and is used for code generation of immutable classes and unions.

-  **weather:** [https://pub.dev/packages/weather](https://pub.dev/packages/weather) is a package uses [the OpenWeatherMAP API](https://openweathermap.org/) to get the current weather status as well as weather forecasts.
