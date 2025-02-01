//
//  AppDelegate.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let user = UserManager.shared.getOrCreateUser()
        print("UserID: ", user.id)
        configureRealm()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

//MARK: - Realm
extension AppDelegate {
    // realm의 현재 스케마 버전 조회
    func checkRealmVersion() {
        do {
            let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
            let schemaVersion = try schemaVersionAtURL(realmURL)
            print("현재 Realm 스키마 버전: \(schemaVersion)", realmURL)
        } catch {
            print("Realm 파일을 찾을 수 없거나 스키마 버전을 조회할 수 없습니다.")
        }
    }
    // realm 스케마 버전 관리 (모델의 변경 확장을 고려 )
    func configureRealm() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                // 현재는 버전을 바꿀 예정이 없으므로 일단 비워둠
            }
            
        )
        Realm.Configuration.defaultConfiguration = config
        
        checkRealmVersion()
    }
}

