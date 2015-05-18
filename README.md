# Yelply
Swift (Xcode 6.3.1) Yelp Client

Let's build a yelp client using the greatness of Swift.

Time spent: N/A

Required

Search results page
- [x] Table rows should be dynamic height according to the content height
- [x] Custom cells should have the proper Auto Layout constraints
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
Filter page. Unfortunately, not all the filters are supported in the Yelp API.
- [ ] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
- [X] The filters table should be organized into sections as in the mock.
- [ ] You can use the default UISwitch for on/off states. Optional: implement a custom switch
- [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
- [X] Display some of the available Yelp categories (choose any 3-4 that you want).

Optional

Search results page
- [ ] Infinite scroll for restaurant results
- [ ] Implement map view of restaurant results
Filter page
- [ ] Radius filter should expand as in the real Yelp app
- [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)
- [ ] Implement the restaurant detail page.

Walkthrough of user stories:

![Alt text](/gif/rotten-tomatoes-gif.gif?raw=true "Optional Title")

Installation

- Requires Xcode 6.3 beta
- Retrieve the Yelp API tokens from http://developer.yelp.com
- Create a folder called Config in the main folder (the one that contains the Podfile)
- In the config folder, create YelpLightConfig.xcconfig
- Inside YelpLightConfig.xcconfig, change the following strings:
  - yelpConsumerKey = your-consumer-token
  - yelpConsumerSecret = your-consumer-secret
  - yelpToken = your-token
  - yelpTokenSecret = your-secret

GIF created with LiceCap.
