###Requirements (Done, Nil)

- (Done) User authentication via login.
- (Done) Initiate an inspection using the 'start' endpoint of the local webserver.
- (Done) Save inspections in a persistent storage, accommodating both draft and completed states.
- (Done) Finalize and submit inspections using the 'submit' endpoint of the local webserver.
 
I developed this project as simple and understandable as possible. 
I have used MVVM architecture pattern as the requirement contains interaction with APIs and database and using MVVM makes it easy to manage business logic and view code separately. It also helps to write reusable, scalable and testable code.
I have used SwiftUI for design as it is declarative and faster way to build UI and have kept UI design very simple, the design can certainly be made better
I have used aync/await for api calls as it is the most simple way to call an async task.
I have added unit test cases for view models.
Looking forward to hearing from you.
