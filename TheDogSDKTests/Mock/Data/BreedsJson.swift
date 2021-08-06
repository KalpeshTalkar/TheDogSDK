//
//  BreedsJson.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 24/04/21.
//

import Foundation

struct BreedsJson {

    static let breedsJson = """
    [
      {
        "bred_for": "Small rodent hunting, lapdog",
        "breed_group": "Toy",
        "height": {
          "imperial": "9 - 11.5",
          "metric": "23 - 29"
        },
        "id": 1,
        "image": {
          "height": 1199,
          "id": "BJa4kxc4X",
          "url": "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg",
          "width": 1600
        },
        "life_span": "10 - 12 years",
        "name": "Affenpinscher",
        "origin": "Germany, France",
        "reference_image_id": "BJa4kxc4X",
        "temperament": "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
        "weight": {
          "imperial": "6 - 13",
          "metric": "3 - 6"
        }
      },
      {
        "bred_for": "Coursing and hunting",
        "breed_group": "Hound",
        "country_code": "AG",
        "height": {
          "imperial": "25 - 27",
          "metric": "64 - 69"
        },
        "id": 2,
        "image": {
          "height": 380,
          "id": "hMyT4CDXR",
          "url": "https://cdn2.thedogapi.com/images/hMyT4CDXR.jpg",
          "width": 606
        },
        "life_span": "10 - 13 years",
        "name": "Afghan Hound",
        "origin": "Afghanistan, Iran, Pakistan",
        "reference_image_id": "hMyT4CDXR",
        "temperament": "Aloof, Clownish, Dignified, Independent, Happy",
        "weight": {
          "imperial": "50 - 60",
          "metric": "23 - 27"
        }
      }
    ]
    """

    static let breedsSearchJson = """
    [
      {
        "bred_for": "Lapdog",
        "breed_group": "Toy",
        "height": {
          "imperial": "10 - 12",
          "metric": "25 - 30"
        },
        "id": 201,
        "life_span": "12 - 14 years",
        "name": "Pug",
        "reference_image_id": "HyJvcl9N7",
        "temperament": "Docile, Clever, Charming, Stubborn, Sociable, Playful, Quiet, Attentive",
        "weight": {
          "imperial": "14 - 18",
          "metric": "6 - 8"
        }
      },
      {
        "breed_group": "Mixed",
        "height": {
          "imperial": "8 - 15",
          "metric": "20 - 38"
        },
        "id": 202,
        "life_span": "12 - 14 years",
        "name": "Pugapoo",
        "weight": {
          "imperial": "10 - 30",
          "metric": "5 - 14"
        }
      },
      {
        "breed_group": "Mixed",
        "height": {
          "imperial": "8 - 15",
          "metric": "20 - 38"
        },
        "id": 203,
        "life_span": "12 - 14 years",
        "name": "Puggle",
        "temperament": "Affectionate, Willful, Sweet-Tempered, Keen, Sociable, Spirited, Lively, Loyal, Playful, Determined, Gentle, Intelligent, Happy, Loving, Watchful, Brave, Hunting Instinct",
        "weight": {
          "imperial": "15 - 30",
          "metric": "7 - 14"
        }
      }
    ]
    """

    static let breedsEmptyResultsJson = """
    []
    """
}
