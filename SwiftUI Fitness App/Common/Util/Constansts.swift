//
//  Constansts.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

class Constants {
    static let globalRadius = 14
    
    static var fitnessTips: [String] { [
        " Identify your \"why,\"  \"what,\" and \"how\" so you can be clear about your goals (you can even write these down).",
        "Try starting with three 30-minute workouts a week to pace yourself.",
        "Prioritize consistency over intensity.",
        "Find other active people to support your efforts.",
        "Do workouts you actually like—you're more likely to stick with it.",
        "Invest in a great pair of shoes.",
        "To avoid burnout and injury, start slow and take breaks during your workouts.",
        "Accept that you'll have setbacks, and that's OK.",
        " Think of working out as an act of self-care.",
        "Don't skip your warm-up and cool down.",
        "Master fundamental movements like squats and lunges before getting fancy.",
        "Don't compare yourself to people who are further along in their fitness journey.",
        "Know that results don’t happen right away, and that’s OK.",
        "Tune into that post-workout high, and enjoy it.",
        "If you're into numbers and stats, try wearing a heart-rate monitor to see how your body's working in real time.",
        "Set athletic goals, like doing push-ups on your toes instead of your knees or running a certain distance.",
        "Nix excuses by laying out your workout clothes, signing up for workouts, and meal prepping fueling foods.",
        "Practice gratitude for what your body can do right now (no matter what your future goals are)."
    ]}
    
    static let USER_DEFAULTS_IS_USER_LOGGED_IN = "isUserLoggedIn"
    static let USER_DEFAULTS_EXERCISE_TYPE = "exerciseType"
    static let USER_DEFAULTS_DIET_TYPE = "dietType"
    
    
    // firebase nodes
    static let FIREBASE_USERS_NODE = "users"
    static let FIREBASE_FITNESS_NODE = "fitness"
    static let FIREBASE_WORKOUTS_NODE = "workouts"
    static let FIREBASE_DIETS_NODE = "diets"
    static let FIREBASE_EMAIL_NODE = "email"
    static let FIREBASE_USERNAME_NODE = "username"
    static let FIREBASE_IS_USER_REGISTRATION_STATUS_PENDING_NODE = "isUserRegistrationStatusPending"
    static let FIREBASE_PROFILE_IMAGE_NODE = "profileImage"
    static let FIREBASE_AGE_NODE = "age"
    static let FIREBASE_GENDER_NODE = "gender"
    static let FIREBASE_WEIGHT_NODE = "weight"
    static let FIREBASE_HEIGHT_NODE = "height"
    static let FIREBASE_FITNESS_GOAL_NODE = "fitnessGoal"
    static let FIREBASE_EXERCISE_TYPE_NODE = "exerciseType"
    static let FIREBASE_DIET_TYPE_NODE = "dietType"
    static let FIREBASE_TITLE_NODE = "title"
    static let FIREBASE_TIME_NODE = "time"
    static let FIREBASE_IMAGE_NODE = "image"
    static let FIREBASE_CALORIE_NODE = "calorie"
    static let FIREBASE_MEALS_NODE = "meals"
    static let FIREBASE_NAME_NODE = "name"
    static let FIREBASE_DESCRIPTION_NODE = "description"
    static let FIREBASE_DURATION_NODE = "duration"
    static let FIREBASE_MOVEMENTS_NODE = "movements"
    static let FIREBASE_TARGET_NODE = "target"
    static let FIREBASE_QUANTITY_NODE = "quantity"
}
