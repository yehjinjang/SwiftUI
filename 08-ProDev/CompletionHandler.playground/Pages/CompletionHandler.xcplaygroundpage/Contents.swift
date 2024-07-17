import UIKit

enum BigError: Error {
    case powerOutage
    case endOfTheWorld
}

enum Response {
    case ok
    case no
}

let startTime = NSDate()

func doSomething(completion: (Result<Response, BigError>) -> Void) {
    print("Start task")
    Thread.sleep(forTimeInterval: 2)
    
    let randomNumber = Int.random(in: 0..<2)
    if randomNumber == 0 {
        completion(.failure(.powerOutage))
        return
    }
    
    completion(.success(.ok))
}

doSomething { result in
    switch result {
    case .success(let response):
        print("Result = \(response)")
    case .failure(let error):
        print("This is the error = \(error)")
    }
    print("End task")
}

let endTime = NSDate()
print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds.")
