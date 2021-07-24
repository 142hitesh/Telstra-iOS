# Telstra-iOS

The Cat application allow the user to see gifs from the <a href="https://thecatapi.com/">The Cat API</a>.
* Allow the user to choose whether to search gif, images or both.
* Filtered out excluded catgories while displaying images (i.e "hats"). An excluded catgories can be configured in *AppConfig.swift*.

## Architecture
iOS project implemented with MVVM architecture pattern. MVVM (Model-View-ViewModel) is an architectural pattern based on MVC and MVP, which attempts to more clearly separate the development of user-interfaces (UI) from that of the business logic and behaviour in an application.

Project
-----
### Configuration
*`AppConfig.swift` - Struct to capture the configuration data required to function the application

### API Service
*`RequestService.swift` - Service or client to request the data from the server using *URLSession*.
*`ResponseHandler.swift` - Handle the server response by mapping raw data with the respective Data Models using *JSONDecoder*.

### Model
*`Cat.swift` - Data Model holds the cat information to be presented.

### View Model
*`CatViewModel.swift` - Manage and format the data to be displayed in the view. Confirmed to *CatViewModelProtocol* which will be exposed to the *View* to handle the user actions. *View Model* use the *CatViewModelDelegate* protocol to communicate with the *View* to update the user-interfaces.

### View and/or View Controller
*`CatViewController.swift` - Responsible to capture and send the user actions to the *View Model* and shows whatever *View Model* tells it.
*`CatImageCell.swift` - The collection view cell to load cat images (Use <a href="https://cocoapods.org/pods/SwiftyGif">SwiftGif pod</a>).

## Includes
* Unit tests for Presentation, Domain and Network layers.
* Dark mode support.

## Requirements
* Xcode version 12.x+, Swift 5.0+

## Developed By
Hitesh Vaghasiya hitu.vaghasiya@gmail.com



 
