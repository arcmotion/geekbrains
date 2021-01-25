import UIKit

protocol Togglable {
    mutating func toggle()
}

enum ToggleState: Togglable {
    case on, off
    mutating func toggle() {
        switch self {
            case .on:
                self = .off
            case .off:
                self = .on
        }
        
    }
}
enum DoorState: Togglable {
    case opened, closed
    mutating func toggle() {
        switch self {
            case .opened:
                self = .closed
            case .closed:
                self = .opened
        }
        
    }
}

enum CarAction {
    case openDoor
    case closeDoor
    case startEngine
    case stopEngine
    case turnOnNitro
    case turnOffNitro
    case fillTrunk(Int)
    case emptyTrunk(Int)
}

protocol CarProto{
    var model: String { get set }
    var year: Int{ get set }
    var engineState: ToggleState {get set}
    var doorState : DoorState {get set}
    mutating func performAction(action: CarAction)
}

extension CarProto{

    mutating func toggleEngineState(){
        self.engineState.toggle()
    }
    mutating func toggleDoorState(){
        self.doorState.toggle()
    }
}



class Car: CarProto{
    
    var model: String
    var year: Int
    
    var engineState = ToggleState.off
    var doorState = DoorState.closed
    
    init(model: String, year: Int){
        self.model = model
        self.year = year
    }
    func performAction(action: CarAction) {
        switch action {
        case .openDoor:
            self.doorState = DoorState.opened
            print("\(self.model) door opened")
        case .closeDoor:
            self.doorState = DoorState.closed
            print("\(self.model) door closed")
        case .startEngine:
            self.engineState = ToggleState.on
            print("\(self.model) engine started")
        case .stopEngine:
            self.engineState = ToggleState.off
            print("\(self.model) engine stopped")
        default:
            print("Invalid action")
        }
    }

}

var baseCar = Car(model: "Mercedes", year: 2015)

baseCar.engineState
baseCar.toggleEngineState()
baseCar.engineState

enum TrunkState {
    case full, empty
    mutating func toggle(){
        switch self{
        case .full:
            self = .empty
        case .empty:
            self = .full
        }
    }
}

/*---------------Truck car----------------*/
class TruckCar: Car {
    var trunkState: TrunkState = .empty
    func toggleTruckState(){
        trunkState.toggle()
    }
}

extension TruckCar: CustomStringConvertible{
    var description: String {
        return "Trunk state: \(trunkState), engine state: \(engineState), door state: \(doorState)"
    }
}
var truckCar = TruckCar(model: "Ford", year: 2006)
print(truckCar)
truckCar.toggleEngineState()
truckCar.toggleDoorState()
truckCar.toggleTruckState()
print(truckCar)

/*---------------Sport car----------------*/

class SportCar: Car {
    var nitroState: ToggleState = .off
    func toggleNitro(){
        nitroState.toggle()
    }
}

extension SportCar: CustomStringConvertible{
    var description: String {
        return "Nitro state: \(nitroState), engine state: \(engineState), doorState: \(doorState)"
    }
}

var sportCar = SportCar(model: "Ferrari", year: 2020)
print(sportCar)
sportCar.toggleNitro()
sportCar.toggleEngineState()
sportCar.toggleDoorState()
print(sportCar)
