//
//  Constants.swift
//  pixel-city
//
//  Created by Kent Nguyen on 10/31/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

let apiKey = "aa170d1e2e9f822b97b11494642fc018"

func flickrUrl(forApiKey key: String, withAnnotaion annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
    print(url)
    return url
}
