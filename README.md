# SyncZone 

- [Description](#description)
  - [About the Project](#about-the-project)
  - [Features](#features)
  - [Buid with](#buid-with)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Architecture](#architecture)
- [Screenshots](#screenshots)


## Description

### About the Project
SyncZone is a SwiftUI application designed to facilitate time zone synchronization and meeting scheduling across different time zones.


### Features
- Time Zone Synchronization: Helps users synchronize and compare multiple time zones effortlessly.
- Meeting Scheduler: Enables scheduling meetings that accommodate participants from different geographical locations.
- City-to-Time Zone Mapping: Provides a comprehensive mapping of cities to their respective time zones for quick reference.

### Build with
- SwiftUI: Used for building the user interface.
- Firebase Firestore: Backend database for storing and retrieving user data.
- CoreLocation: Used for location-based services to fetch user's current location.
- CityToTimeZone Mapping: Custom mapping to correlate cities with their respective time zones.

## Getting Started 
To run the application locally:

- Clone this repository.
```bash
https://github.com/heyanlu/SyncZone
```
- Open SyncZone.xcodeproj in Xcode.
- Build and run the project on your device or simulator.

## Usage
- Sign In/Sign Up: Use your Firebase credentials to log in or create a new account.
- Add Sync Lists: Create new lists by specifying a name, selected cities, start time, and end time.
- Edit/Delete Lists: Tap on a list item to edit its details or swipe left to delete it.
- View Details: Tap "View" to see detailed information about a specific list item.
- Sync Time Zones: Use the app's location services to sync your current time zone with selected cities.

## Architect
![structure](https://github.com/heyanlu/SyncZone/assets/116776352/4c5fdb15-be7b-4466-a836-b0687c8777d4)

## Screenshots
![Blank diagram](https://github.com/heyanlu/SyncZone/assets/116776352/2107be7d-bfbb-464c-b960-9dcf70f36bd6)

