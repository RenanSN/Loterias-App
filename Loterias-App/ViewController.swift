//
//  ViewController.swift
//  Loterias-App
//
//  Created by mac on 02/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

enum TipoJogo: String{
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universo: Int) -> [Int] {
    var resultados:[Int] = []
    while resultados.count < total {
        let numero = Int(arc4random_uniform(UInt32(universo))+1)
        if !resultados.contains(numero){
            resultados.append(numero)
        }
    }
    return resultados.sorted()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarResultados(tipo: .megasena)
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var scTipoJogo: UISegmentedControl!
    @IBOutlet var btnNumeros: [UIButton]!
    
    func mostrarResultados(tipo: TipoJogo){
        lblTitulo.text = tipo.rawValue
        
        var game: [Int] = []
        
        switch tipo {
            case .megasena:
                game = 6>-<60
                btnNumeros.last!.isHidden = false
            case .quina:
                game = 5>-<80
                btnNumeros.last!.isHidden = true
        }
        
        for (index, numerosArray) in game.enumerated(){
            btnNumeros[index].setTitle("\(numerosArray)", for: .normal)
        }
    }
    
    @IBAction func btnJogo() {
        switch scTipoJogo.selectedSegmentIndex {
            case 0:
                mostrarResultados(tipo: .megasena)
            default:
                mostrarResultados(tipo: .quina)
        }
    }
    
}

