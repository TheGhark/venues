# Architecture
The code is divided into three parts:
1. `Venues` project
2. `Components` framework
3. `Packages` dependencies using `SwiftPackages`

The reason behind it is to keep the components away from the main app, plus they don't have to be compiled every time there's a change in `Venues`.

## Storyboard/Xib-less app
All the components and the main view controller are made with constraints created by code. The main reason is to reduce the number of files, as well as making much simpler to deal with any possible conflicts. Also, it is much easier to maintain, and expand.

# TO-DO
Few things are missing:
1. Extract all the layout logic into a `Layout.swift`, where pinning to `superview` is a `func` away
2. Improving the performance of `ImageDownloader`. Though it is using `SDWebImage`, the scrolling is not ideal
3. Add UI tests for the `VenuesViewController` to test different scenarios (i.e. _retry_ button when the network is offline)
4. Sort upcoming venues by date
5. Separate upcoming venues by month
## Nice to have
It would be ideal to have support for offline mode, so the _No connection_ error is not shown. Instead, the venues are stored locally using `CoreData`

# Improvements
Sorting several venues locally, and then dividing them by month is a costly operation, and it would have to be replicated for each platform (i.e. web, android). Instead, the back-end could:
1. Provide venues already sorted by date
2. Provide venues already divided into sections (more below)
3. Allow to lazily fetch more venues

## Venues divided into sections
The back-end can easily provide venues in the following manner:
```json
{
	"sections": [
		{
			"date": "2021-06-18",
			"venues": [ // Where venues are already sorted by date
				{
					"image_url":"https://images.unsplash.com/photo-1582642017153-e36e8796b3f8",
					"cost": "free",
					"location": "The Penny Farthing",
					"venue": "Manhattan",
					"start_time": "2021-06-18T17:00:00Z",
					"end_time": "2021-06-18T22:00:00Z"
				}
			]
		}
	]
}
```
