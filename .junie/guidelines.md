# Project Guidelines
    
This is a placeholder of the project guidelines for Junie.
Replace this text with any project-level instructions for Junie, e.g.:

* This project is a project about mobile anime (film) streaming mobile application
* This project use the clean architecture with flutter, with 4 layer, presentation, domain, data, application
* This project use the freezed for generate code.
* This project is use the dependencies injection, and State management via RiverPod.
* Please follow the clean architecture code style
* The presentation (UI screen) just interact with controller, controller interact with application, application interact with repository
* The controller is control the state of screen, and call the application
* Application layer is where handle app logic and call the repository for query or mutant the data
* Repository is the thing to call the remote api via http DIO, then provide the DTO, the DTO must to transfer to the domain model via mapper
* Please read the lib/common folder for reusable model, function, if you think a function or model is reusable then write down it to this folder

As an option you can ask Junie to create these guidelines for you.
