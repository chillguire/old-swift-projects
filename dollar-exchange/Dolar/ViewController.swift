//
//  ViewController.swift
//  Dolar
//
//  Created by Ricardo Avendaño on 5/5/20.
//  Copyright © 2020 Ricardo Avendaño. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
	let baseURL = "https://s3.amazonaws.com/dolartoday/data.json"
	let currencyArray = ["USD","EUR","COL"]
	
	@IBOutlet weak var labelFecha: UILabel!
	@IBOutlet weak var labelPrecioDolar: UILabel!
	@IBOutlet weak var currencyPicker: UIPickerView!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		currencyPicker.delegate = self
		currencyPicker.dataSource = self
		
		getCurrencyData(url: baseURL, currency: currencyArray[0])
		
	}
	
	/* UI Picker methods */

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return currencyArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return currencyArray[row]
	}
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		getCurrencyData(url: baseURL, currency: currencyArray[row])
	}
	
	/* UI Picker methods */
	
	
	/* Networking */
	
	func getCurrencyData(url: String, currency: String) {

		Alamofire.request(url, method: .get)
	            .responseJSON { response in
	                if response.result.isSuccess {
					
	                    let currencyJSON : JSON = JSON(response.result.value!)
					
					print(currencyJSON)

					self.updateCurrencyData(json: currencyJSON, currency: currency)
					
	                } else {
					
	                    print("Error: \(String(describing: response.result.error))")
					
	                    self.labelPrecioDolar.text = "Error de conexión"
					
	                }
	            }
	    }
	
	/* Networking */
	
	
	/* JSON parsing */
	
	func updateCurrencyData(json: JSON, currency: String) {
		
		if let currencyResult = json[currency]["transferencia"].double {
			
			labelPrecioDolar.text = String(format: "Bs. %.2f", currencyResult)
			labelFecha.text = json["_timestamp"]["fecha"].string
	        
		   } else if var currencyResult = json[currency]["transfer"].double {
			
			currencyResult = 1 / currencyResult
			
			labelPrecioDolar.text = String(format: "Bs. %.2f", currencyResult)
			labelFecha.text = json["_timestamp"]["fecha"].string
			
		} else {
			labelPrecioDolar.text = "Cambio no disponible"
			labelFecha.text = json["_timestamp"]["fecha"].string
		}
	}
	
	/* JSON parsing */
	
	
}
