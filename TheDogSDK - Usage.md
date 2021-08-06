# Welcome to TheDogSDK!

##  An open, free, read & write API all about Dogs
A public service API all about Dogs, free to use when making your fancy new iOS App. 
The SDK gives you access to 1000's of dog images, and breeds.
[Get your license now.](https://thedogapi.com/#pricing)

# Usage

## Integration
Add TheDogSDK.xcframework to your project by dragging and dropping it in **Frameworks, Libraries, and Embedded Content** of your target settings.

You will need to import the SDK before using it.
`import TheDogSDk`

Provide your API key to the SDK
`DogSDK.instance.apiKey = "YOUR_APY_KEY"`

## Breeds
Get all breeds.

`page` - Current page to paginate through results.
`limit` - Results per page
```
DogService.getAllBreeds(page: 1, limit: 20) { [weak self] (result, error) in
    if let breeds = result?.data {
        // Display breeds
    }
}
```

## Breeds Search
Search breeds by breed name.

`breedName` - Name of the breed to search.
`page` - Current page to paginate through results.
`limit` - Results per page
```
DogService.searchBreeds(breedName: "pug", page: 1, limit: 20) { [weak self] (result, error) in
    if let breeds = result?.data {
        // Display breeds
    }
}
```

## Images Search

Search breed images by breed name.

`params` - `BreadImageParams` object.
```
var params = BreedImageParams(page: 1, limit: 20)
params.breed = "labrador" // search images by breed name
params.size = .small // size of the image
params.mimeTypes = [.jpg, .png, .gif] // type of images
params.order = .ascending // sort order
params.hasBreeds = true // get images with breeds info

DogService.searchImages(params: params) { [weak self] (result, error) in
    if let images = result?.data {
        // Display images
    }
}
```
