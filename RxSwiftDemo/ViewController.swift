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

	let n = Variable(1) // 可变的变量
	@IBOutlet weak var textFieldOutlet: UITextField!
	@IBOutlet weak var buttonOutlet: UIButton!

	var textFieldDisp: Disposable!

	let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		// testTextField()
		testBackground()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func onButton(sender: AnyObject) {
		// testFunc()

		if textFieldDisp != nil {
			textFieldDisp.dispose() // 取消订阅
			textFieldDisp = nil
		} else {
			testTextField()
		}

//		textFieldOutlet.rx_hidden.onNext(true)//隐藏了..
//		textFieldOutlet.rx_enabled.onNext(false)//不可用了...

	}
}

extension ViewController {

	func testFunc() {
		n.asObservable()
			.observeOn(OperationQueueScheduler(operationQueue: NSOperationQueue()))
			.map { int in
				print("Test \(NSThread.isMainThread()) \(#function) \(int)")
		}.subscribe().addDisposableTo(DisposeBag())
	}

	func testTextField() {
		// 订阅TextField的文本的改变
		// 1:
//		textFieldDisp = textFieldOutlet.rx_text.subscribe { event in
//			print("event \(#function) \(event) \(event.element!)")
//		}

		// 2:
		textFieldDisp = textFieldOutlet.rx_text.subscribeNext { element in
			print("\(NSThread.isMainThread()) \(#function) \(element)")
		}

//		textFieldOutlet.rx_selected.on { event in
//			print("Test \(NSThread.isMainThread()) \(#function) \(event.)")
//		}

	}

	func testBackground() {
		// ConcurrentDispatchQueueScheduler
//        ConcurrentDispatchQueueScheduler.init(queue: dispatch_queue_t)

//        OperationQueueScheduler

		textFieldOutlet.rx_text
			.observeOn(OperationQueueScheduler.init(operationQueue: NSOperationQueue()))
			.map { str in
				print("map1 \(NSThread.isMainThread()) \(#function) \(str)")
				// return "map1"
		}.observeOn(MainScheduler.instance)
			.map { str in
				print("map2 \(NSThread.isMainThread()) \(#function) \(str)")
		}.observeOn(OperationQueueScheduler.init(operationQueue: NSOperationQueue()))
			.subscribeNext { str in
				print("onnext \(NSThread.isMainThread()) \(#function) \(str)")
		}
			.addDisposableTo(disposeBag)
	}
}

