# PeopleManager

Architecture : MVC

Design Patterns Used:
- Observer
- Delegate
- Facade
- Simple Factory

##### Assumptions

  - Assumed that one person can only be either a teacher or a student. System won't let you add same person (with same national ID number) twice.

 Notes:
`Teacher` and `Student` Core Data models inherit from `Person` model. To keep a single `NSFetchResultsController` to fetch both `Student` and `Teacher` Entities(`Person` Entities) I've maintained a `groupType` attribute since `NSFetchResultsController` doesn't support inheritance and grouping by entity type.


