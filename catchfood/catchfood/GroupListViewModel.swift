//
//  GroupListViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import RxSwift
import RxCocoa

class GroupListViewModel {
    let groupListsRelay = BehaviorRelay<[Group]>(value: [.dummyData])
}
