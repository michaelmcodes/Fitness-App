//
//  Workout.swift
//  SwiftUI Fitness App
//
//  Created by Michael on 5/20/23.
//

import Foundation

struct Workout: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var duration: String
    var description: String
    var image: String
    var movements: [Movement]
}

struct Movement: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var target: String
    var quantity: String
    var image: String
}

extension Workout {
    static var dummyData: [Workout] {
        return [
            .init(title: "Push Day",
                  duration: "1 month",
                  description: "In the “push” workout you train all the upper body pushing muscles, i.e. the chest, shoulders and triceps.",
                  image: "https://www.muscleandfitness.com/wp-content/uploads/2016/09/Bodybuilder-Working-Out-His-Upper-Body-With-Cable-Crossover-Exercise.jpg?quality=86&strip=all",
                  movements: [
                    .init(title: "Dumbbell Chest Press",
                          target: "Chest",
                          quantity: "3x8",
                          image: "https://hortonbarbell.com/wp-content/uploads/2022/12/Dumbbell-Bench-Press-Alternatives.png"),
                    .init(title: "Cable Upper Chest Fly",
                          target: "Upper chest",
                          quantity: "4x12",
                          image: "https://fitnessvolt.com/wp-content/uploads/2018/05/gthnc-5gtr0-2.jpg"
                         ),
                    .init(title: "Cable Crossovers",
                          target: "Lower chest",
                          quantity: "4x10",
                          image: "https://cdn.shopify.com/s/files/1/0554/1704/5132/articles/cable-crossover-exercise.jpg?v=1678169934"
                         ),
                    .init(title: "Lateral Raises",
                          target: "Side delts",
                          quantity: "4x15",
                          image: "https://mirafit.co.uk/wp/wp-content/uploads/2022/01/Lat-Raise-blog-Header-1024x683.jpg"
                         ),
                    .init(title: "Overhead Press",
                          target: "Front and side delts",
                          quantity: "3x8",
                          image: "https://cdn.mos.cms.futurecdn.net/wga2zSh3wHj5dAWXpGgK45.jpg"
                         ),
                    .init(title: "Lying Tricep Extensions",
                          target: "Triceps (long head)",
                          quantity: "4x10",
                          image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP1xxVc98EXVpP67vMCgIOfiEp2YEJaeXAzQ&usqp=CAU"
                         ),
                    .init(title: "Tricep Pushdown",
                          target: "Triceps (short head)",
                          quantity: "3x12",
                          image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD_4N3q7k2Qar-RQwKk8MF63moOFRz9HoLEg&usqp=CAU"
                         )
                    
                  ]),
            .init(title: "Pull Day",
                  duration: "2 months",
                  description: "In the “pull” workout you train all the upper body pulling muscles, i.e. the back and biceps.",
                  image: "https://www.muscleandfitness.com/wp-content/uploads/2019/01/high-cable-curl-1109-GettyImages-1057569482.jpg?quality=86&strip=all",
                  movements: [
                    .init(title: "Dumbbell Chest Press",
                          target: "Chest",
                          quantity: "3x8",
                          image: "https://hortonbarbell.com/wp-content/uploads/2022/12/Dumbbell-Bench-Press-Alternatives.png"),
                    .init(title: "Cable Upper Chest Fly",
                          target: "Upper chest",
                          quantity: "4x12",
                          image: "https://fitnessvolt.com/wp-content/uploads/2018/05/gthnc-5gtr0-2.jpg"
                         ),
                    .init(title: "Cable Crossovers",
                          target: "Lower chest",
                          quantity: "4x10",
                          image: "https://cdn.shopify.com/s/files/1/0554/1704/5132/articles/cable-crossover-exercise.jpg?v=1678169934"
                         ),
                    .init(title: "Lateral Raises",
                          target: "Side delts",
                          quantity: "4x15",
                          image: "https://mirafit.co.uk/wp/wp-content/uploads/2022/01/Lat-Raise-blog-Header-1024x683.jpg"
                         ),
                    
                  ]),
            .init(title: "Leg Day",
                  duration: "3 months",
                  description: "And in the “legs” workout you train the entire lower body, i.e. the quads, hamstrings, calves and abdominals.",
                  image: "https://cdn.mos.cms.futurecdn.net/Jqcjo7KKVwPNWDqbSWxsoF.jpg",
                  movements: []),
            .init(title: "Full Body",
                  duration: "2.5 months",
                  description: "This means that you get the maximum overlap of movements within the same workout, and the muscle groups being trained get an overall benefit from this overlap.",
                  image: "https://blog.nasm.org/hubfs/hypertrophy-workouts.jpg",
                  movements: [
                    .init(title: "Dumbbell Chest Press",
                          target: "Chest",
                          quantity: "3x8",
                          image: "https://hortonbarbell.com/wp-content/uploads/2022/12/Dumbbell-Bench-Press-Alternatives.png"),
                    .init(title: "Cable Crossovers",
                          target: "Lower chest",
                          quantity: "4x10",
                          image: "https://cdn.shopify.com/s/files/1/0554/1704/5132/articles/cable-crossover-exercise.jpg?v=1678169934"
                         ),
                    .init(title: "Lateral Raises",
                          target: "Side delts",
                          quantity: "4x15",
                          image: "https://mirafit.co.uk/wp/wp-content/uploads/2022/01/Lat-Raise-blog-Header-1024x683.jpg"
                         ),
                    .init(title: "Overhead Press",
                          target: "Front and side delts",
                          quantity: "3x8",
                          image: "https://cdn.mos.cms.futurecdn.net/wga2zSh3wHj5dAWXpGgK45.jpg"
                         ),
                    .init(title: "Lying Tricep Extensions",
                          target: "Triceps (long head)",
                          quantity: "4x10",
                          image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP1xxVc98EXVpP67vMCgIOfiEp2YEJaeXAzQ&usqp=CAU"
                         ),
                    .init(title: "Tricep Pushdown",
                          target: "Triceps (short head)",
                          quantity: "3x12",
                          image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD_4N3q7k2Qar-RQwKk8MF63moOFRz9HoLEg&usqp=CAU"
                         )
                    
                  ]),
        ]
        
        
    }
}
