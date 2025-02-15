//
//  RealmManager.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import Foundation

import RealmSwift

protocol Crudable {
    associatedtype EntityType: BaseEntity
    func create(_ object: EntityType)
    func read(_ objectType: EntityType.Type) -> Results<EntityType>
    func update(_ object: EntityType)
    func delete(_ object: EntityType)
}

class RealmManager {
    static let shared = RealmManager()

    private let realm: Realm
    
    private init() {
        /*
         생성시에 발생할수있는 Crush 는 디스크 공간부족,파일손상등의 이유로 현저히 낮고, Realm 생성이 안된다면 앱을 사용할이유가
         없기때문에 강제 언랩핑으로 진행하여도 되지만 0% 가 아니라면 안된다.
         */
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
        
    }
    
}
//MARK: - Read
/*
 Read의 Case
 1.A(date)~B(date)의 Transaction의 객체 리스트
 2.A(date)~B(date)의 Budget 객체 리스트
 3.어떤 지출이나, 소비에따른 검색기능도 고려해볼수 있음
 4. plan 카테고리에서 완료된것과 완료되지 않은것들의에 대한 리스트
 
 
 */
extension RealmManager {
    
    func read<T: Object>(_ objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    func fetchDiaryBetweenDates(_ startDate: Date, _ endDate: Date) -> Results<Transaction> {
        return self.realm.objects(Transaction.self).filter("date BETWEEN {%@, %@}", startDate, endDate)
    }
    
    func fetchDiaryBetweenDates2(_ startDate: Date, _ endDate: Date) -> Results<Budget> {
        return self.realm.objects(Budget.self).filter("date BETWEEN {%@, %@}", startDate, endDate)
    }
    
    
//    func fetchDiaryBetweenDates(_ oneday: Date) -> Results<Transaction> {
//        let date = DateManager.shared.calculateStartAndEndOfDay(for: oneday)
//        
//        
//        return self.realm.objects(Transaction.self).filter("date BETWEEN {%@, %@}", date.0, date.1)
//    }
    
}


//MARK: - CUD
extension RealmManager {
    // ✅ 데이터 생성 (Create)
    func create<T>(_ object: T) where T : Object {
        do {
            try realm.write {
                realm.add(object)
            }
            print("✅ 데이터 저장 성공: \(object)")
        } catch {
            print("❌ 데이터 저장 실패: \(error.localizedDescription)")
        }
    }

    func update(_ block: @escaping () -> Void) {
        do {
            let realm = self.realm
            try realm.write {
                block()  // ✅ 트랜잭션 블록 실행
            }
        } catch {
            print("Realm 업데이트 오류: \(error)")
        }
    }
    
    func fetchTransactions(for userId: String) -> Results<Transaction> {
        return realm.objects(Transaction.self).filter("userId == %@", userId)
    }

    // ✅ 데이터 수정 (Update)
    func update<T>(_ object: T) where T : Object {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
            print("✅ 데이터 업데이트 성공: \(object)")
        } catch {
            print("❌ 데이터 업데이트 실패: \(error.localizedDescription)")
        }
    }

    // ✅ 데이터 삭제 (Delete)
    func delete<T>(_ object: T) where T : Object {
        do {
            try realm.write {
                realm.delete(object)
            }
            print("✅ 데이터 삭제 성공: \(object)")
        } catch {
            print("❌ 데이터 삭제 실패: \(error.localizedDescription)")
        }
    }
}







class UserManager {
    static let shared = UserManager()

    private let realm: Realm
    
    private init() {
        /*
         생성시에 발생할수있는 Crush 는 디스크 공간부족,파일손상등의 이유로 현저히 낮고, Realm 생성이 안된다면 앱을 사용할이유가
         없기때문에 강제 언랩핑으로 진행하여도 되지만 0% 가 아니라면 안된다.
         */
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
        
    }
    
    
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
    
    func resetRealmDatabase() {
        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL
        
        if let path = defaultRealmPath?.path {
            do {
                try FileManager.default.removeItem(atPath: path)
                print("Realm 데이터베이스 초기화 완료")
            } catch {
                print("Realm 데이터베이스 초기화 실패: \(error.localizedDescription)")
            }
        }
    }
    
}






