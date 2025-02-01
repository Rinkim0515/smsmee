//
//  RealmManager.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import Foundation

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    /*
     생성시에 발생할수있는 Crush 는 디스크 공간부족,파일손상등의 이유로 현저히 낮고, Realm 생성이 안된다면 앱을 사용할이유가
     없기때문에 강제 언랩핑으로 진행
     */
    private let realm = try! Realm()
    
    private init() {}
    
    func getOrCreateUser() -> User {
            if let existingUser = realm.objects(User.self).first {
                return existingUser //  이미 존재하는 User 반환
            } else {
                let newUser = User(name: "Default User")
                try! realm.write {
                    realm.add(newUser)
                }
                return newUser // 새로 생성한 User 반환
            }
        }
}
