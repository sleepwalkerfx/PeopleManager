# PeopleManager

Architecture : MVC
Language: Swift 4.1

Design Patterns Used:
- Observer
- Delegate
- Facade
- Simple Factory

##### Assumptions

  - Assumed that one person can only be either a teacher or a student. System won't let you add same person (with same national ID number) twice.

 Notes:
`Teacher` and `Student` Core Data models inherit from `Person` model. To keep a single `NSFetchResultsController` to fetch both `Student` and `Teacher` Entities(`Person` entities) I've maintained a groupType attribute since `NSFetchResultsController` doesn't support grouping by entity type.

##### Running the project
- Pull the repo
- Update dependancies with a `pod install`
- open `PeopleManager.xcworkspace`
