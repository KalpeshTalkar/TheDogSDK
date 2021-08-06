//
//  ImagesSearchJson.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 24/04/21.
//

import Foundation

struct ImagesJson {

    static let imagesSearchJson = """
    [
      {
        "breeds": [
          {
            "bred_for": "Coursing hares",
            "breed_group": "Hound",
            "height": {
              "imperial": "27 - 30",
              "metric": "69 - 76"
            },
            "id": 127,
            "life_span": "10 - 13 years",
            "name": "Greyhound",
            "reference_image_id": "ryNYMx94X",
            "temperament": "Affectionate, Athletic, Gentle, Intelligent, Quiet, Even Tempered",
            "weight": {
              "imperial": "50 - 70",
              "metric": "23 - 32"
            }
          }
        ],
        "height": 681,
        "id": "ryNYMx94X",
        "url": "https://cdn2.thedogapi.com/images/ryNYMx94X_1280.jpg",
        "width": 1024
      },
      {
        "breeds": [],
        "height": 217,
        "id": "H1yHQaaNX",
        "url": "https://cdn2.thedogapi.com/images/H1yHQaaNX.gif",
        "width": 350
      }
    ]
    """
}
