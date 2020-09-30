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
    self.serviceUUID = serviceUUID
    self.delegate = delegate
    
    super.init()
    
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  func writeValue(value: Int8) {
    guard let peripheral = connectedPeripheral, let characteristic = writableCharacteristic else {
      return
    }
    
    let data = Data.dataWithValue(value: value)
    peripheral.writeValue(data, for: characteristic, type: .withResponse)
  }
}

extension CoreBluetoothIO: CBCentralManagerDelegate {
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    peripheral.discoverServices(nil)
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    connectedPeripheral = peripheral
    
    if let connectedPeripheral = connectedPeripheral {
      connectedPeripheral.delegate = self
      centralManager.connect(connectedPeripheral, options: nil)
    }
    centralManager.stopScan()
  }
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    if central.state == .poweredOn {
      centralManager.scanForPeripherals(withServices: [CBUUID(string: serviceUUID)], options: nil)
      print("on")
    }
  }
}

extension CoreBluetoothIO: CBPeripheralDelegate {
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    guard let services = peripheral.services else {
      return
    }
    
    targetService = services.first
    if let service = services.first {
      targetService = service
      peripheral.discoverCharacteristics(nil, for: service)
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    guard let characteristics = service.characteristics else {
      return
    }
    
    for characteristic in characteristics {
      if characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse) {
        writableCharacteristic = characteristic
      }
      peripheral.setNotifyValue(true, for: characteristic)
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    guard let data = characteristic.value, let delegate = delegate else {
      return
    }
    
    delegate.coreBluetoothIO(coreBluetoothIO: self, didReceiveValue: data.int8Value())
  }
}
