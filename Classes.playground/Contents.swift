import UIKit

enum NitroState {
    case on, off
}

enum Transmission {
    case manual, auto
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

class Car {
    var model: String
    var year: Int
    var transmission:Transmission
    
    var doorOpened: Bool = false
    var engineStarted: Bool = false
    
    init(model: String, year: Int, transmission:Transmission){
        self.model = model
        self.year = year
        self.transmission = transmission
    }
    
    func performAction(_ action: CarAction){
        switch action {
        case .openDoor:
            self.doorOpened = true
            print("\(self.model) door opened")
        case .closeDoor:
            self.doorOpened = false
            print("\(self.model) door closed")
        case .startEngine:
            self.engineStarted = true
            print("\(self.model) engine started")
        case .stopEngine:
            self.engineStarted = false
            print("\(self.model) engine stopped")
        default:
            print("Invalid action")
        }
        
    }
}

class SportCar: Car {
    var nitro: NitroState
    override init(model: String, year: Int, transmission: Transmission){
        self.nitro = .off
        super.init(model: model, year: year, transmission: transmission)
    }
    override func performAction(_ action: CarAction) {
        switch action {
            case .turnOnNitro:
                self.nitro = .on
                print("\(model.capitalized) nitro is on")
            case .turnOffNitro:
                self.nitro = .off
                print("\(model.capitalized) nitro is off")
            default:
                super.performAction(action)
            
        }
    }

}
class TrunkCar: Car {
    var trunkVolume: Int
    var filledTrunkSize = 0
    init(model: String, year: Int, transmission: Transmission, trunkVolume: Int){
        self.trunkVolume = trunkVolume
        super.init(model: model, year: year, transmission: transmission)
        
    }
    override func performAction(_ action: CarAction) {
        switch action {
            case .fillTrunk(let weight):
                    guard weight > 0  else {
                        print("Incorrect value")
                        return
                    }
                    guard self.trunkVolume >= self.filledTrunkSize + weight else {
                        print("No room for your stuff")
                        return
                    }
                    self.filledTrunkSize += weight
                    print("\(weight) kg added to the trunk")
            case .emptyTrunk(let weight):
                guard weight <= filledTrunkSize && weight > 0 else {
                    print("Invalid size")
                    return
                }
                filledTrunkSize -= weight
                print("\(weight) kg subtracted")
            default:
                super.performAction(action)
            
        }
    }

}
print("---------Base Car-----------")
let honda = Car(model: "Honda", year: 2005, transmission: .manual)
honda.performAction(.openDoor)
honda.performAction(.turnOnNitro)
honda.performAction(.startEngine)
dump(honda)

print("---------Sport Car-----------")
var subaru = SportCar(model: "subaru", year: 2020, transmission: .auto)
subaru.performAction(.turnOnNitro)
subaru.performAction(.turnOffNitro)
subaru.performAction(.openDoor)
subaru.performAction(.startEngine)
dump(subaru)

print("---------Truck-----------")
var truck = TrunkCar(model: "Mercedes Truck", year: 2008, transmission: .manual, trunkVolume: 5000)
truck.performAction(.openDoor)
truck.performAction(.fillTrunk(700))
dump(truck)
