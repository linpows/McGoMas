//
//  UserSession.swift
//  McGoMas
//  Tutorials:
// https://benmcmahen.com/authentication-with-swiftui-and-firebase/
// https://medium.com/ios-os-x-development/learn-master-%EF%B8%8F-the-basics-of-combine-in-5-minutes-639421268219
//  Created by Mikayla Richardson on 3/23/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class UserSession: ObservableObject {
    //Combine Publisher. Subscribers get notified of changes made AFTER they start listening
    var didChange = PassthroughSubject<UserSession, Never>()
    //User has a property observer "didSet". Will send the UserSession to subscribers every time a property of User is set
    @Published var user: User? { didSet {self.didChange.send(self)}}
    var stateHandler: AuthStateDidChangeListenerHandle?
    //Reference for our app's database
    var databaseRef: DatabaseReference?
    
    func listen() { //Listen for authentications
        stateHandler = Auth.auth().addStateDidChangeListener { (auth, authUser) in
            if let authUser = authUser { //if user exists...
                self.user = User(userID: authUser.uid, name: authUser.displayName, email: authUser.email!)
                self.databaseRef = Database.database().reference().child("logs").child(authUser.uid)
            }
            else { //No user signed in
                self.user = nil
                self.databaseRef = nil
            }
            
        }
    }
    
    //Sign in with given email password.
    //Upon completion, calls given handler
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        //Will trigger the listen method to update the current user
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    //Create a new user with email password.
    //Upon completion, calls given handler
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signOut () -> Bool {
        do { //Attempt to sign out
            try Auth.auth().signOut()
            self.user = nil
            self.databaseRef = nil
            return true
        }
        catch { //Return false if couldn't
            return false
        }
        
    }
    
    func updateProfileInfo(email: String, displayName: String?, handler: @escaping UserProfileChangeCallback) {
        if let displayName = displayName {
            if let request = Auth.auth().currentUser?.createProfileChangeRequest() {
                request.displayName = displayName
                request.commitChanges(completion: handler)
            }
        }
        
        Auth.auth().currentUser?.updateEmail(to: email, completion: handler)
        
        user!.email = email
        user!.name = displayName
    }
    
    func uploadCardio(workout: CardioModel) {
        
        let dict: [String : Any] = [
            "date": workout.cardio!.date.timeIntervalSince1970,
            "distance": workout.cardio!.distance ?? 0,
            "unit": workout.cardio!.distanceUnit ?? "",
            "time": workout.cardio!.time ?? 0,
            "workoutType": workout.cardio!.workoutType.stringRep
        ]
        
        if let ref = databaseRef {
            ref.child(workout.id.uuidString)
            .setValue(dict)
        }
        
    }
    
    /*
     uploads weight entry to database
     */
    func uploadWeight(workout: WeightModel) {
        
        let encoder = JSONEncoder()
        var setJSON = ""
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let setData = try encoder.encode(workout.weight!.sets.sets)
            setJSON = String(data: setData, encoding: .utf8) ?? ""
        }
        catch {
            print("Error in JSON serialization")
        }
        
        let dict: [String : Any] = [
            "date": workout.weight!.dayCompleted.timeIntervalSince1970,
            "workoutType": WorkoutType.weights.stringRep,
            "sets": setJSON
        ]
        
        if let ref = databaseRef {
            ref.child(workout.id.uuidString)
            .setValue(dict)
        }
    }
    
    /*
    Retrieves all of the user's workouts
    */
    func getWorkouts() -> [AnyObject] {
        let workouts: [AnyObject] = []
        // Fetch here
        return workouts
    }
    
    /*
     Overrides the workout with the given identifier with the supplied workout
     */
    func updateWorkout(identifier: String, workout: String) {
        
    }
    
    func stopListening() { //Stop listening for authentication
        if let stateHandler = stateHandler {
            Auth.auth().removeStateDidChangeListener(stateHandler)
        }
    }
}

class User {
    var userID: String
    var email: String
    var name: String?
    
    init(userID: String, name: String?, email: String) {
        self.userID = userID
        self.name = name
        self.email = email
    }
}
