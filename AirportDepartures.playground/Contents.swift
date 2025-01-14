import UIKit

//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
// Create an Enum for the Flight status in JFK. Contains all flight status possbilities.
enum FlightStatus: String {
    case scheduled
    case canceled
    case boarding
}

// Create class for Airport: Includes airport name and code abbreviation
struct Airport {
    let name: String
    let code: String
}

// Create stucture for Flight type.
struct Flight {
    let destination: String
    let airline: String
    let flightNumber: String
    let departureTime: Date? 
    let departureTerminal: String?
    let flightStatus: FlightStatus
}

// Create a class for Departure Board type.
class DepartureBoard {
    var departureFlights: [Flight]
    var airport: Airport
    
    init(departureFlgihts: [Flight], airport: Airport) {
        self.departureFlights = departureFlgihts
        self.airport = airport
    }
    
    // Function from section 5.
    func alertPassengers() {
        for x in departureFlights {
            
            // Declairing unwrapped properties
            var depTime: String = "TBD"
            var terminal: String = "TBD"
            
            // Unwrapping Optionsals
            if x.departureTime != nil {
                depTime = "\(x.departureTime!)"
            }
            
            if x.departureTerminal != nil {
                terminal = "\(x.departureTerminal!)"
            }
            
            
            switch x.flightStatus {
            case .canceled:
                print("We're sorry your flight to \(x.destination) has been canceled, here is a $500 voucher")
            case .scheduled:
                print("Your flight to \(x.destination) is scheduled to depart at \(depTime) from terminal: \(terminal)")
            case .boarding:
                print("Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon.")
            }
        
        }
    }
}
//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
// Create three instances of flights.
let flight1 = Flight(destination: "Atlanta", airline: "Delta Air Lines", flightNumber: "DL 2341", departureTime: Date(), departureTerminal: "4", flightStatus: .scheduled)
let flight2 = Flight(destination: "Los Angeles", airline: "American Airlines", flightNumber: "AA 171", departureTime: nil, departureTerminal: "8", flightStatus: .canceled)
let flight3 = Flight(destination: "San Francisco", airline: "Alaska Airlines", flightNumber: "AS 769", departureTime: Date(), departureTerminal: nil, flightStatus: .boarding)

// Create instance of a Nassau Airport
let nassauAirport = Airport(name: "Lynden Pindling International Airport", code: "NAS")

// Create instance of Nassau Depature Flights array
var nassauDepartures: [Flight] = []

// Add flights to a departures array .
nassauDepartures.append(flight1)
nassauDepartures.append(flight2)
nassauDepartures.append(flight3)

var nasDepartureBoard = DepartureBoard(departureFlgihts: nassauDepartures, airport: nassauAirport)
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
// Create free-standing function that prints Nassau Flight information from Departure Board.
func printDepartures(departureBoard: DepartureBoard = nasDepartureBoard) {
    for x in departureBoard.departureFlights {
            print(x.destination)
            print(x.airline)
            print(x.flightNumber)
            print(x.departureTime ?? "No depature time. Check back soon.")
            print(x.departureTerminal ?? "No assigned terminal. Check back soon.")
            print(x.flightStatus.rawValue)
    }
}
printDepartures()
//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
// Second Funciton
func printDepartures2(departureBoard: DepartureBoard = nasDepartureBoard) {
    for x in departureBoard.departureFlights {
        
        // Declairing unwrapped properties
        var depTime: String = ""
        var terminal: String = ""
        
        // Unwrapping Optionsals
        if x.departureTime != nil {
            depTime = "\(x.departureTime!)"
        }
        
        if x.departureTerminal != nil {
            terminal = "\(x.departureTerminal!)"
        }
        
        // Printing Board w/ format
        print("Destination: \(x.destination) Airline: \(x.airline) Flight: \(x.flightNumber) Departure Time: \(depTime) Terminal: \(terminal) Status: \(x.flightStatus)")
            
    }
}
printDepartures2()


//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
nasDepartureBoard.alertPassengers()



//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    // Costs
    let bagCost: Double = 25.00
    let mileCost: Double = 0.10
    
    let totalAirfare = (Double(travelers) * Double(distance) * mileCost) + (Double(checkedBags) * bagCost)
    
    return totalAirfare
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
