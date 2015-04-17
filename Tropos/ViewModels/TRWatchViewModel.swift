import Foundation

class TRWatchViewModel : NSObject {
    let phrase = "Phrase"
    let imageName = "clear-day"
    let weatherUpdate: TRWeatherUpdate

    init(weatherUpdate: TRWeatherUpdate) {
        self.weatherUpdate = weatherUpdate
    }
}