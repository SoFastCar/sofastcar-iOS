//
//  CoreBluetoothIO.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/30.
//  Copyright © 2020 김광수. All rights reserved.
//

import CoreBluetooth

protocol CoreBluetoothIODelegate: class {
  func coreBluetoothIO(coreBluetoothIO: CoreBluetoothIO, didReceiveValue value: Int8)
}

class CoreBluetoothIO: NSObject {
  let serviceUUID: String
  weak var delegate: CoreBluetoothIODelegate?
  
  var centralManager: CBCentralManager!
  var connectedPeripheral: CBPeripheral?
  var targetService: CBService?
  var writableCharacteristic: CBCharacteristic?
  
  init(serviceUUID: String, delegate: CoreBluetoothIODelegate?) {
    super.init()
    self.serviceUUID = serviceUUID
    self.delegate = delegate
    
  }
}
