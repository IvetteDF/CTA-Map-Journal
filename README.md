# Train of Thought (AKA CTA Map Journal)

### Description
Train of Thought is an iOS app that allows you to tie the journal entries you write while on public transit to the train stations or the trips between them (currently only for the 'L' in Chicago). The app gives you many different convenient ways to select a train station to associate with your journal entry: through a map view, through a current location locator button, and through a list of train stations by train line. The app also displays information about the different train lines accessible through each train station and a map view displaying pins of all train stations, giving the user helpful transit information in addition to a space to reflect.

When reflecting on public transit, sometimes your words aren't enough to capture how you're feeling. That is why user's can also submit up to 3 links to attach to their journal entry. A user could link a playlist, a YouTube video, an image URL, a poem, etc.

If the user selects the emotion analysis option when submitting a journal entry, the app also analyzes the emotion in submitted journal entries and aggregates the information for all train stations or by train station, displaying the analyzed data in a pie chart. The user can control the time interval over which submitted journal entries are analyzed by selecting a start date in settings (only available for all journal entries, not filtered by train station). The user can also customize the colors displayed in the mood charts in settings.

Users have access to their journal entries either in a list of all journal entries or filtered by train station. 

### Dependencies
- SwiftUI
- MapKit
- CoreLocation
- Firebase (firebase-ios-sdk)
- [Emotion Analysis API by Twinword, Inc (available through RapidAPI)]( https://rapidapi.com/twinword/api/emotion-analysis/)
- CTA Train Station JSON data included, but updated data can be found at: https://www.transitchicago.com/data/

### Installation
1. Clone this repository and open the project in XCode.
2. [Add Google Firebase:](https://firebase.google.com/docs/ios/setup)
    1. Create a Firebase project in your Firebase Console (log in using Google account).
    2. Register your app in the Firebase console using your project's bundle id.
    3. Download the Firebase configuration file from your Firebase console and add it to your project.
    4. Install the firebase-ios-sdk package through Swift Package Manager.
    5. Make sure Firebase is initialized in your app by checking that `FirebaseApp.configure()` is in CTA\_Map_Journal_App.swift in the init().
3. Create a file Secrets.swift in the CTA-Map-Journal folder.
4. In Secrets.swift, create a `struct` called `Secrets`.
5. Subscribe to the [Emotion Analysis API by Twinword, Inc:](https://rapidapi.com/twinword/api/emotion-analysis/pricing)
    1. Get your API Key from the Rapid API Developer Dashboard.
    2. In the `Secrets` struct in Secrets.swift, create a static constant called `APIKey` declared as the `String` data type.
    3. Assign `APIKey`'s value to the API Key from Emotion Analysis API as a `String`. It should look like this:
    ```
    import Foundation

    struct Secrets {
        static let APIKey: String = "YOUR API KEY HERE"
    }
    ```
6. When first running the app, a DomainError will print in console from Firebase asking you to create an index for the firebase query in the `EmotionDataViewModel` method `getAllEmotionData`. Follow the url given in the error and build an index in your Firestore database. It may take a few minutes to build.
7. Watch this [video](https://youtu.be/3GwjfUFyY6M)

The **Train of Thought** app was developed by [Ada Developers Academy](https://adadevelopersacademy.org/) cohort 16 student [Ivette Fernandez](https://www.linkedin.com/in/ivettedfernandez/).
    

