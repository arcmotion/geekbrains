import UIKit

enum EngineState {
    case started, stopped
}
enum WindowState {
    case opened, closed
}

struct SportCar {
    let trunkVolume:Float = 100 //immutable field
    var model: String
    var year: Int

    var engineStarted:EngineState = .stopped
    var windowsOpened:WindowState = .closed
    var trunkIsFull: Bool {
        get {
            return self.luggageSize == self.trunkVolume
        }
    }
    var luggageSize: Float = 0.0 {
        didSet {
            print("New luggage size is \(luggageSize) kg.")
            if self.trunkIsFull {
                print("Trunk is full.")
            }
        }
    }
    
    mutating func startEngine() {
        guard self.engineStarted == .stopped  else{
            print("Engine is already working")
            return
        }
        self.engineStarted = .started
        print("\(self.model.capitalized) engine started")
    }
    mutating func stopEngine() {
        guard self.engineStarted == .started else{
            print("Engine isn't working")
            return
        }
        self.engineStarted = .stopped
        print("\(self.model.capitalized) engine stopped")
    }
    
    //Alternative state change
    mutating func setWindowsState(_ state: WindowState){
        guard self.windowsOpened != state else {
            print("Window is already \(self.windowsOpened == .opened ? "opened": "closed")")
            return
        }
        self.windowsOpened = state
        print("Window is \(state)")
    }
    
    mutating func setLuggage(_ luggage:Float){
        let availableVolume = self.trunkVolume - self.luggageSize
        guard luggage <= availableVolume else{
            print("Car trunk has no room for your luggage. Storage space available: \(availableVolume)kg")
            return
        }

        self.luggageSize += luggage
    
        
    }
}

var subaru = SportCar(model: "subaru", year: 2020)
subaru.startEngine()
subaru.setWindowsState(.opened)
subaru.stopEngine()
subaru.setLuggage(100)
subaru.setLuggage(100)
subaru.setLuggage(-30)
dump(subaru)

struct TruckCar {
    let carcaseVolume:Float = 5000 //immutable field
    var model: String
    var year: Int

    var engineStarted:EngineState = .stopped
    var windowsOpened:WindowState = .closed
    var truckIsFull: Bool {
        get {
            return self.luggageSize == self.carcaseVolume
        }
    }
    var luggageSize: Float = 0.0 {
        didSet {
            print("New luggage size is \(luggageSize) kg.")
            if self.truckIsFull {
                print("Truck is full.")
            }
        }
    }
    
    mutating func startEngine() {
        guard self.engineStarted == .stopped  else{
            print("Engine is already working")
            return
        }
        self.engineStarted = .started
        print("\(self.model.capitalized) engine started")
    }
    mutating func stopEngine() {
        guard self.engineStarted == .started else{
            print("Engine isn't working")
            return
        }
        self.engineStarted = .stopped
        print("\(self.model.capitalized) engine stopped")
    }
    
    //Alternative state change
    mutating func setWindowsState(_ state: WindowState){
        guard self.windowsOpened != state else {
            print("Window is already \(self.windowsOpened == .opened ? "opened": "closed")")
            return
        }
        self.windowsOpened = state
        print("Window is \(state)")
    }
    
    mutating func setLuggage(_ luggage:Float){
        let availableVolume = self.carcaseVolume - self.luggageSize
        guard luggage <= availableVolume else{
            print("Truck has no room for your luggage. Storage space available: \(availableVolume)kg")
            return
        }

        self.luggageSize += luggage
    
        
    }
}

var truck = TruckCar(model: "mercedes", year: 1996)
var truck2 = TruckCar(model: "ford", year: 2015)

truck.startEngine()
truck2.startEngine()
truck.setWindowsState(.closed)
truck.stopEngine()
truck.setLuggage(4500)
truck.setLuggage(5000)
truck.setLuggage(-30)

dump(truck)
