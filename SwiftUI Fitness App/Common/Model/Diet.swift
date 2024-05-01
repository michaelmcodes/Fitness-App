//
//  Diet.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

struct Diet: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var image: String
    var time: String
    var calories: String
    var meals: [Meal]
}

struct Meal: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var calories: String
}

extension Diet {
    static var dummyData: [Diet] {
        return [
            .init(title: "Low Calorie, High Protein Diet",
                  image: "https://img.freepik.com/free-photo/top-view-table-full-delicious-food-composition_23-2149141352.jpg",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            .init(title: "High Protein Diet",
                  image: "https://www.healthkart.com/connect/wp-content/uploads/2022/07/900x500_thumbnail_HK-how-to-have-a-balanced-diet-1.png",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            .init(title: "Low Carbs Diet",
                  image: "https://burst.shopifycdn.com/photos/flatlay-iron-skillet-with-meat-and-other-food.jpg?width=1200&format=pjpg&exif=1&iptc=1",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            .init(title: "Low Calorie, Low Protein Diet",
                  image: "https://thumbor.forbes.com/thumbor/fit-in/x/https://www.forbes.com/health/wp-content/uploads/2021/11/PeganDiet.jpeg.jpg",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            .init(title: "High Calorie, High Protein Diet",
                  image: "https://images.squarespace-cdn.com/content/v1/57879a6cbebafb879f256735/1667226425853-GFTZP1P5PWAME97VPC6M/AD011219-21_original.jpg",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            .init(title: "Low Calorie Diet",
                  image: "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            .init(title: "Simple Diet",
                  image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZi46hUxiQ8DDJ2ft29nMYZ1CQ8r-BVoMAMg&usqp=CAU",
                  time: "3 months",
                  calories: "2740",
                  meals: [
                    .init(name: "Breakfast",
                          description: "6 egg whites and 1 whole egg, 100 g oatmeal with milk",
                          calories: "460"),
                    .init(name: "Lunch",
                          description: "Extra lean ground beef, baked beans, cashews",
                          calories: "600"),
                    .init(name: "Pre-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Post-Workout",
                          description: "94% fat free popcorn, whey protein shake",
                          calories: "540"),
                    .init(name: "Dinner",
                          description: "Tilapia (8oz), veggies (350-400g), fish oil (5g)",
                          calories: "600"),
                  ]),
            
        ]
    }
}
