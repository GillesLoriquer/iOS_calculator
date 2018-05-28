//
//  ViewController.swift
//  Calculator
//
//  Created by Gilles Loriquer on 08/03/2018.
//  Copyright © 2018 GilLo. All rights reserved.
//

import UIKit

// Classe d'énumération des opérations
enum Operation:String {
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "x"
    case null = "null"
}

class ViewController: UIViewController {
    
    // Définition du label d'affichage de saisie et de résultat
    @IBOutlet weak var outputLabel: UILabel!
    
    // Variables
    var _runningNumber:String = ""
    var _leftValue:String = ""
    var _rightValue:String = ""
    var _result:String = ""
    var _currentOperation:Operation = .null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = "0"
    }
    
    // Fonction qui récupère et affiche les numéros pressés en fonction de leur tag
    @IBAction func numberPressed(_ sender: RoundButton) {
        if _runningNumber.count < 10 {
            _runningNumber += "\(sender.tag)"
            outputLabel.text = _runningNumber
        }
    }
    
    // Fonction qui affiche le . pour les décimaux
    @IBAction func dotPressed(_ sender: RoundButton) {
        if (_runningNumber.count < 8 && !_runningNumber.contains(".")) {
            _runningNumber += "."
            outputLabel.text = _runningNumber
        }
    }
    
    // Fonction qui réinitialise la calculatrice
    @IBAction func allClearPressed(_ sender: RoundButton) {
        _runningNumber = ""
        _leftValue = ""
        _rightValue = ""
        _result = ""
        _currentOperation = .null
        outputLabel.text = "0"
    }
    
    // Fonction qui définit la valeur en positif / négatif (pas réussi à l'implémenter...)
    @IBAction func changeSignPressed(_ sender: RoundButton) {
    }
    
    // Fonction qui affiche le pourcentage d'une valeur (pas réussi à l'implémenter...)
    @IBAction func percentPressed(_ sender: RoundButton) {
    }
    
    // Fonction appellée lorsque la touche diviser est pressée
    @IBAction func dividePressed(_ sender: RoundButton) {
        operation(operation:.divide)
    }
    
    // Fonction appellée lorsque la touche multiplier est pressée
    @IBAction func multiplyPressed(_ sender: RoundButton) {
        operation(operation:.multiply)
    }
    
    // Fonction appellée lorsque la touche soustraire est pressée
    @IBAction func substractPressed(_ sender: RoundButton) {
        operation(operation:.substract)
    }
    
    // Fonction appellée lorsque la touche ajouter est pressée
    @IBAction func addPressed(_ sender: RoundButton) {
        operation(operation:.add)
    }
    
    // Fonction appellée lorsque la touche égale est pressée
    @IBAction func equalsPressed(_ sender: RoundButton) {
        operation(operation:_currentOperation)
    }
    
    // Fonction qui effectue les opérations
    func operation(operation:Operation) {
        if _currentOperation == .null {
            _leftValue = _runningNumber
            _runningNumber = ""
            _currentOperation = operation
        } else {
            if _runningNumber != "" {
                _rightValue = _runningNumber
                _runningNumber = ""
            
                if _currentOperation == .add {
                    _result = "\(Double(_leftValue)! + Double(_rightValue)!)"
                } else if _currentOperation == .substract {
                    _result = "\(Double(_leftValue)! - Double(_rightValue)!)"
                } else if _currentOperation == .divide {
                    _result = "\(Double(_leftValue)! / Double(_rightValue)!)"
                } else if _currentOperation == .multiply {
                    _result = "\(Double(_leftValue)! * Double(_rightValue)!)"
                }
                _leftValue = _result
                
                if (Double(_result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    _result = "\(Int(Double(_result)!))"
                }
                outputLabel.text = showDigits(number:_result)
            }
        }
        _currentOperation = operation
    }
    
    // Fonction qui permet le formatage (pas d'affichage du .0 losrqu'il s'agit d'un entier)
    func showDigits(number:String) -> String {
        if (Double(number)!.truncatingRemainder(dividingBy: 1) == 0) {
            return "\(Int(Double(number)!))"
        } else {
            return number
        }
    }
}
