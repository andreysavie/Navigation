//
//  BrutForce.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 18.05.2022.
//

import Foundation
import UIKit


class BrutForce {
    
    let passwordToUnlock =  "1!ggsdfgdsfg3"
    
    //    var isBlack: Bool = false {
    //        didSet {
    //            if isBlack {
    //                self.view.backgroundColor = .black
    //            } else {
    //                self.view.backgroundColor = .white
    //            }
    //        }
    //    }
    //
    //    @IBAction func onBut(_ sender: Any) {
    //        isBlack.toggle()
    //    }
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        DispatchQueue.global(qos: .background).async {
    //            self.bruteForce(passwordToUnlock: "1111")
    //        }
    
    
    func bruteForce(passwordToUnlock: String) -> String {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            // Your stuff here
            print(password)
            // Your stuff here
        }
        return password
    }
    
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
    : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string
    
    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
        
        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    
    return str
}


