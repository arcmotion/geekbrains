import UIKit

enum CarAcrion {
    case openDoor
    case closeDoor
    case openWindows
    case closeWindows
    case startEngine
    case stopEngine
    case fillTrunk(Int)
    case emptyTrunk(Int)
}

struct Car {
    let maxTrunkSize: Int
    private(set) var isDoorOpen: Bool = false
    private(set) var isWindowOpen: Bool = false
    private(set) var isEngineStarted: Bool = false
    private(set) var filledTrunkSize: Int = 0 {
        didSet {
            print("trunk size is: \(filledTrunkSize)")
        }
    }

    mutating func performAction(_ action: CarAcrion) {
        switch action {
        case .openDoor:
            self.isDoorOpen = true
            print("Door opened")
        case .closeDoor:
            self.isDoorOpen = false
            print("Door closed")
        case .openWindows:
            self.isWindowOpen = true
            print("Windows opened")
        case .closeWindows:
            self.isWindowOpen = false
            print("Windows closed")
        case .startEngine:
            self.isEngineStarted = true
            print("Engine started")
        case .stopEngine:
            self.isEngineStarted = false
            print("Engine stopped")
        case .fillTrunk(let weight):
            guard weight > 0  else {
                print("Incorrect value")
                return
            }
            guard self.maxTrunkSize >= self.filledTrunkSize + weight else {
                print("No room for your luggage")
                return
            }
            self.filledTrunkSize += weight
        case .emptyTrunk(let size):
            guard size > 0  else {
                print("Incorrect value")
                return
            }
            guard self.filledTrunkSize >= size else {
                print("No room for your luggage")
                return
            }
            self.filledTrunkSize -= size
        }
    }
}

var subaru = Car(maxTrunkSize: 100)
subaru.performAction(.openDoor)
subaru.performAction(.fillTrunk(90))
subaru.performAction(.emptyTrunk(50))
