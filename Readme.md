# Fun With Flags

This is a simple native iOS application written in Swift in MVC architecture with ViewModels for one way binding. The main purpose is to let user users explore Countries from [Countries API](https://restcountries.eu/), search through them and see basic details.

## Main App Features
- List all available countries
- Quick Look Countries indexed by the first letter of their names
- Search Countries by keyword
- View Country Flag, Map and other details.
- Country data is persisted on disk, so internet connection is only required on first start. Once data is loaded and persisted, we re-fetch and check if anything was changed.

## Architecture Overview
Mainly the app follows the MVC + ViewModel design pattern. Because of the simplicity of this app, the ViewModel is used in only one direction. In addition to that, all concernes are placed in separate class ensuring better reusability and testability.

## UI Design Approach
Clean and native design with flat style and only one accent color. Also all element sizes use dynamic fonts so the app is compliant to the Accesibility Dynamic Text Size configuration.

## Unit Tests
There are couple of test cases, used to cover the Model Parsing and ViewModel behaviour. Note that there is no 100% test coverage, these few tests are written for demo purpose.

## UI Tests
There are couple of UI Tests that excersize the most commonly used scenarios:
	- Tap on country that is initially visible.
	- Search for a country and then tap on it.
	- Search for a non valid keyword and confirm that there is no match.

## Dependencies
The application is built fully native without the need to  introduce and dependency management tool.


## Build, Test, Run requirements and steps
Because the app is fully native it only requires Xcode 10+ version and regular Build, Test, Run actions.

## Resources
Countries are fetched from: https://restcountries.eu

Images are pre-downloaded from: https://github.com/hjnilsson/country-flags

Flag app icon:  https://www.flaticon.com/authors/smashicons

## License

License is MIT.
