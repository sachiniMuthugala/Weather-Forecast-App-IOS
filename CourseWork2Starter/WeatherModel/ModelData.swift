import Foundation
class ModelData: ObservableObject {
    @Published var forecast: Forecast?
    @Published  var userLocation: String = ""
    @Published var airPollution: AirPolutionModelData?
    
    init() {
        self.forecast = load("london.json")
    }
    

    func loadData(lat: Double, lon: Double) async throws -> Forecast {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=7c2e0706ae7a1ccfdaeb11e163b6e34a")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            //print(data)
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
            
            return forecastData
        } catch {
            throw error
        }
    }
    
    func LoadAirPollutionData() async throws -> AirPolutionModelData {
        guard let lat = forecast?.lat, let lon = forecast?.lon else {
            fatalError("Couldn't find in lat & lon in forecast data.")
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&units=metric&appid=7c2e0706ae7a1ccfdaeb11e163b6e34a"
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url!)
        
        do {
            let pollutionData = try JSONDecoder().decode(AirPolutionModelData.self, from: data)
            
            DispatchQueue.main.async {
                self.airPollution = pollutionData
            }
            
            return pollutionData
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}
