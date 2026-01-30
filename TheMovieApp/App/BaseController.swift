//
//  BaseController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureViewModel()
        configureConstraints()
    }
    
    func configureUI() {}
    
    func configureViewModel() {}
    
    func configureConstraints() {}
}
