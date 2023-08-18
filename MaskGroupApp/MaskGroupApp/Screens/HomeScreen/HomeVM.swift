//
//  HomeVM.swift
//  MaskGroupApp
//
//  Created by Mohamed Salem on 18/08/2023.
//

import Combine
import Foundation

class HomeVM: ObservableObject {
    private let cancellableBag = CancellableBag()
    let loading: LoadingState = LoadingState()
    private let  useCases: UserUseCasesProtocol = UserUseCases()
    @Published var services: [ServiceDatum] = []
  
    func getAvailableServices() {
        loading.isLoading = true
        useCases.getAvailableServices()
            .subscribe(on: RunLoop.current)
            .receive(on: RunLoop.main)
            .sinkToResult { [weak self] in
                self?.loading.isLoading = false
                switch $0 {
                case let .success(value):
                    if value.statusCode == 201 || value.statusCode == 200 {
                        guard let list = value.data , !list.isEmpty else {
                            return
                        }
                        self?.services = list
                    }else {
                        Alert().showWithCancelButton(with: .alert, title: "Fail", message: value.message ?? "")
                    }
                case let .failure(error):
                    Alert().showWithCancelButton(with: .alert, title: "Fail", message: error.errorDescription ?? "")
                }
            }.store(in: cancellableBag)
    }
    
   
}
