# Boosta

#  Tips

- I have implemented all the requirements and bonus tech in the projectand i will explain them in the 'Description' section.

- In the Networking layer i have used "Moya"

- For reacting programming i have used 'Rxsift' and 'Rxcocoa'.

-  To load the images asyncrounasly i have used 'Kingfisher'.

- I have used 'Swift Package Manager' as my dependency manager.

# APP Structure

## Parants
- (AppDelegate-SceneDelegate)

## Networking
- Contain the APIs file to set up the connections request, and network manager file to set up the network data center

## Models
- Contain all the model's files to decode the json responses.

## Features
- the all App's features i will descripe them in the 'Description' section.

## Resources
- Contain info.plist, assets and the Lunchpad

## Core
- Contain all the helper classes i used in the project.

# Description


## Profile Screen
- I have used the first userId to call the 'users' API and get the album for this user using the 'albums' API and present the results in table view.
- I have used 'Rxswift' and 'Rxcocoa' to bind the albums data source to view controller from view model.

## Photos Screen

- Using the 'albumId' from the Profile Screen i called the 'photo' API and present the result in collection view.
- Using search bar i have implemented the search fearure on the image title's.
- I have used 'Rxswift' and 'Rxcocoa' to bind the photos data source to view controller from view model, i have used them as well to add event to the search bar.

 
## Zoom & Share Screen
 
- I have implemented the 'Zoom' feature using scroll view and adding min and max zoom scale to the scrollView.
- I have implemeted the 'Share' feature by UIActivityViewController seperated the function in 'ShareUtility' in the 'Core' folder.
