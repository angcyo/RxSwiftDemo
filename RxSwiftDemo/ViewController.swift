//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by angcyo on 16/8/22.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

	let n = Variable(1)

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func onButton(sender: AnyObject) {
		test()
	}
}

extension ViewController {
	func test() {
		n.asObservable().map { int in
			print("Test \(NSThread.isMainThread()) \(#function) \(int)")
		}.subscribe()
	}
}

