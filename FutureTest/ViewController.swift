//
//  ViewController.swift
//  FutureTest
//
//  Created by John Davis on 7/4/19.
//  Copyright © 2019 John Davis. All rights reserved.
//
import Combine
import UIKit

class ViewController: UIViewController {

    var future: AnyPublisher<String, Error>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        future = ViewController.makeNumberString(50)
        future?.sink { result in
            print("FUTURE DONE: \(result)")
        }
    }

    static func makeNumberString(_ number: Int) -> AnyPublisher<String, Error> {
        return Combine.Future<Int, Error> { complete in
            DispatchQueue.global(qos: .userInitiated).async {
                complete(.success(number))
            }
        }
        .map { number in
            return "\(number)"
        }
        .eraseToAnyPublisher()
    }
}

