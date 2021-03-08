
/*:
 ##### [다리를 지나는 트럭](https://programmers.co.kr/learn/courses/30/lessons/42583)
 
 트럭 여러대가 다리를 지나간다.  각 트럭들의 무게는 `truck_weights` 배열이다.
 
 트럭은 1초에 1만큼 움직이며 다리의 무게 제한은 `weight`, 다리의 길이는 `bridge_length` 이다.
 
 트럭이 다리에 완전히 오르지 않은 경우는 트럭의 무게를 고려하지 않는다.
 
 모든 트럭이 다리를 건너는데에 소요되는 시간은? 
 
 ---
 
 트럭이 모두 지나갈때 까지 반복문을 수행한다. 반복문의 한번 반복은 1초가 지나가도록 한다.
 
 매 반복마다 다레에 트럭을 1칸씩 이동하고, 트럭이 다리에 오를 수 있는 지 확인한다.
 
 */


import Foundation

func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
  
  /*:
   각 트럭에 대한 정보를 구조체로 표현한다.
   bridgePosition : 다리에서의 트럭의 위치
   weight: 트럭의 무게
   
   */
  struct Truck {
    var bridgePosition: Int
    let weight: Int
    
    mutating func move() {
      self.bridgePosition += 1
    }
  }
  
  let trucks = truck_weights.map { Truck(bridgePosition: 0, weight: $0) }
  
  var time = 0
  var truckIndex = 0
  var bridgeTrucks = [Truck]()
  
  /*:
   배열 내의 트럭을 한칸씩 이동시키고,
   다리의 마지막에 위치한 트럭은 제거한다.
   */
  func moveTruck(_ trucks: inout [Truck]) {
    for i in 0..<trucks.count {
      trucks[i].move()
    }
    if trucks.first?.bridgePosition == bridge_length {
      trucks.removeFirst()
    }
  }
  
  /*:
   다리에 총 트럭 무게를 확인해 트럭이 이동 가능한지 확인 후 반환한다.
   */
  func canAppend(_ trucks: [Truck], newTruckWeight: Int) -> Bool {
    let bridgeWeight = trucks.reduce(0, { $0 + $1.weight })
    return bridgeWeight + newTruckWeight <= weight
  }
  
  //: loop 당 1초씩 증가한다.bridgeTrucks.isEmpty 일때까지 반복.
  repeat {
    time += 1
    moveTruck(&bridgeTrucks)
    
    if truckIndex != truck_weights.count {
      let currentTruck = trucks[truckIndex]
      if canAppend(bridgeTrucks, newTruckWeight: currentTruck.weight) {
        bridgeTrucks.append(currentTruck)
        truckIndex += 1
      }
    }
  } while !bridgeTrucks.isEmpty
  
  return time
}


if solution(2, 10, [7, 4, 5, 6]) == 8 {
  print("solution 1 right")
}

if solution(100, 100, [10]) == 101 {
  print("solution 2 right")
}

if solution(100, 100, [10,10,10,10,10,10,10,10,10,10]) == 110 {
  print("solution 3 right")
}
