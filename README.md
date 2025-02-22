# Gaston
## Introduction
### Project Background
Our project aims to alleviate these concerns by providing solutions to help drivers avoid such inconveniences. By doing so, we hope to reduce the stress of unexpected situations, allowing people to focus on their important matters without worrying about being stuck on the road.
Whether it's ensuring that their vehicle is fueled up in time for an event or offering peace of mind while driving, our goal is to make their driving experience smoother and more worry-free.

### Project Description
This project aspires to develop a mobile application to give the opportunity of buying and booking fuel to it's users, Allowing the communication between fuel distribution companies and the drivers to ensure that the fuel reaches the vehicle fast and safely.

### The Benefits of the Project for the Industry
This project will allow gas and fuel distribution companies to sell fuel to drivers that are stranded on the road with no way to reach regular gas stations thus increase customer numbers and profit.

### Project Problem Statement
Every day, the number of cars on the road continues to grow, and along with it, the challenges drivers face. Issues like running out of fuel in the middle of a journey, missing important events due to time constraints, or not being able to find a gas station are becoming more common.

### Project Goals and Objectives
- The purpose of this project is to help those people whose cars have ran out of fuel on the road or who want to book the fuel in advance for the upcoming event.
- To help companies to sell fuel
- To be the middleman in the transaction
- To bring fuel to stranded cars .

### Project Proposed Solution
The solution promises fast delivery of fuel to cars that have ran out of fuel vehicles on the road. It also allows the drivers to book fuel ahead of time just in case of a emergency.

### Project Software Development Model
Agile Model

### Project Hardware, Software Tools, and Specifications
- Flutter SDK
- Dart
- Android
- Git Version Control System
- Github

### Project Timeline
![gant](https://github.com/user-attachments/assets/554aae17-27c6-489b-bc67-821a97b95e1c)

## Project Architecture Design and Requirements Analysis
### Project User and System Requirements Analysis
#### User requirements
- Creating an account for drivers
- Selecting the desired type of fuel and it's quantity
- Forwarding the location of the vehicle
- Ordering fuel for a desired date/time and location
- Confirmation for order and a billing system for payment 

#### System requirements
- Secure payment infrastructure
- User friendly UI/UX
- User database
- Managing permissions (Location, camera)

### Project Software Lifecycle
![agile](https://github.com/user-attachments/assets/f50db5ff-622d-4e38-97b7-0e523cf47545)

#### Requirement gathering
- Creation of an account for users
- The ability to choose from a catalogue of fuel types and it's quantity
- Sending the location of the vehicle
- Delivery of fuel to a certain place and time in the future
- Sending a conformation of the transaction and the implementation of a billing system



#### System Design
- Based on mobile platform
- Database design: Tables for users, orders and fuel types etc.
- UI design: Payment page, wallet widget, home page, settings page, fuel price widget



#### Coding - Development
- Database: Tables for users, orders and fuel types etc. in Firebase
- Frontend: Flutter UI classes
- Backend: Functions and classes by Dart programming language


#### Testing
- Checking for any possible error in order to fix it them


#### Deployment
- Frequent Releases: Each sprint delivers a new, working version of the app with features like account creation, fuel selection, and payment integration.
- Continuous Integration/Continuous Deployment (CI/CD): Automates testing and deployment to ensure quick and reliable updates of the app to production.
- Incremental Updates: Features are deployed in small increments (e.g., adding location tracking, delivery scheduling, etc.), allowing for constant improvements.
- User Feedback: After each release, user feedback is collected to refine and improve the app.
- Post-Deployment Monitoring: The app’s performance is monitored to fix any issues and provide updates as needed.

### Project System Design
![systemchart](https://github.com/user-attachments/assets/7a317d31-c907-4637-9760-95304a789879)

### Project Unified Modelling Language (UML) Design
![uml](https://github.com/user-attachments/assets/bead5313-2aae-4198-b074-600055055c99)

### Project Database Design
![image](https://github.com/user-attachments/assets/d582166d-e1b7-453f-aa94-3727752cec02)

### Project User Interface Design (UID)
Our app contains 4 main pages: Home, Order, Favourite, Profile

![4](https://github.com/user-attachments/assets/2b8379e6-1119-4554-919a-706880ea0fc4)
![3](https://github.com/user-attachments/assets/ef4844e5-be76-468d-8439-649d7fc0a4e0)
![2](https://github.com/user-attachments/assets/27448884-42e1-41ac-bd0c-470b58758740)
![1](https://github.com/user-attachments/assets/715e6c2e-3353-41b2-8f5f-9e62bb95349d)

### Project Risk Management
![Risk-Management-Process](https://github.com/user-attachments/assets/7a845537-5f0d-4829-b280-d93ce11eb99b)

1. Identity The Risk: Recognize potential risks such as delivery delays, technical issues (app crashes), regulatory compliance, fraud, and customer dissatisfaction.

2. Asses The Risk: Evaluate the likelihood and impact of each risk. Prioritize them based on their severity and probability.

3. Monitoring The Risk: Continuously track risks using analytics, real-time delivery tracking, customer feedback, and updates on regulations.

4. Mitigate The Risk: Develop solutions to minimize or eliminate risks, such as app updates, backup delivery plans, regulatory compliance checks, secure payment systems, and active customer support.

## Project Testing, Setup, Results, and Discussion
### Project Design Approach Testing

The project design is almost acceptable for the application. The Flutter UI classes have been sufficient enough to satisfy the UID. For the gas prices a great API could not be found however the free API was satisfactory for the project. Google Maps was integrated into the checkout process for location information.


### Project Verification and Validation 
#### Verification:
The UI was successfully developed along side its Flutter classes. The UI widgets and pages were filed seperately in project files. The API has underwent the correct procedures (JSON decoding and data processing) and was successfully implemented in to the project. Google maps was buggy in a sense that it was sometimes portrayed locations sent by the users out of place however the team managed to overcome this issue. The QR code system for the checkout process was implemented successfully.

#### Validation:
The log in system in its entirety has proven to be working successfully, same as in app profile and the tracking of the funds in an account. The purchasing system, including the correct displayment of the real time gas prices, pinging real time location of the user to the fuel truck and the qr code verification aystem for the checkout, has proven to be working as intended. Large amounts of users have also been simulated and the application was found to be quite effective at handling large amounts of incoming data traffic. The system itself has also been verified to work coherently together without issue


### Project Quality Assurance and Quality Control Testing
#### For Quality Assurance
We have set strict coding standarts and set up eleborate guidelines before the start of the coding process and ensured all team members were up to par with the required skillset for the job.
During the process of development regular and thorough reviews were conducted to identify potential issues early on.


#### For Quality Control
Multiple types of testing including but not limited to; Unit testing, Integration Testing and Systems testing were implemented to test the application. Individually speaking, for the checkout system two mock accounts were created designated as user1 and truck1 were used to test to see if the correct location was sent to the fuel truck and the final step in the checkout process, being the QR code verification system, was working as intended. The same account, user1, was also used to test if the registration and signing up processes worked as first planned.

### The Target of the Test
The target of this test focuses on the following critical components of the app, specifically designed to support drivers who wish to purchase fuel in advance or those who are stuck on the road and need emergency fuel delivery:
- Login Page:
The test will verify that drivers can securely log in to the app without issues. It ensures that authentication mechanisms (e.g., email, phone number, password, or biometric login) function properly, allowing drivers to access their account seamlessly.

![6](https://github.com/user-attachments/assets/4df5286c-6c1b-4a12-8079-7d2c5184c3f7)
![5](https://github.com/user-attachments/assets/9d44f983-6315-4e28-a1bb-45e96dddfcdf)
![7](https://github.com/user-attachments/assets/2201234a-8876-47e3-96a9-b922772a470b)

- Purchase Fuel:
The test will confirm that drivers can easily navigate the process of purchasing fuel in advance. This includes verifying that the fuel selection, quantity options, and payment processes work correctly, ensuring drivers can make a successful transaction.

![19](https://github.com/user-attachments/assets/e5dbce36-069a-493e-95bf-2173d3ad3ec3)
![20](https://github.com/user-attachments/assets/78f27d71-23c0-49c7-be87-17cd07eb746d)
![21](https://github.com/user-attachments/assets/5bf8348b-23cc-4a6c-8124-254b0ffaf2f6)

- Address Page:
This test will check whether drivers can accurately enter and update their address details. It will also confirm that the app stores and displays the address correctly for delivery purposes, especially if the driver is in a location where they need emergency fuel.

![22](https://github.com/user-attachments/assets/38fe1d99-c243-41cc-8005-6a710a7fbd61)
![14](https://github.com/user-attachments/assets/8380d18e-bbb1-4ed1-b666-129684fac964)

- Favorite Page:
The test will evaluate the functionality of the favorite icon, ensuring drivers can save their preferred fuel stations or locations for quick and easy access. This feature should make the fuel ordering process more convenient for repeat customers.

![23](https://github.com/user-attachments/assets/a935a692-c7ce-430d-b7af-21120032bdd2)
![2](https://github.com/user-attachments/assets/053a515a-da2c-412a-aa7d-33e5ea3059fa)

- Order Page:
This test will ensure that the order page is user-friendly and accurate, allowing drivers to review their fuel order, including fuel type, quantity, and expected delivery time. It will also verify that any special requests or modifications to the order can be made without issues.

![4](https://github.com/user-attachments/assets/6a458139-c90a-40b9-8572-f74df3d0f1fa)
![9](https://github.com/user-attachments/assets/d27cc719-eb81-4ba7-995e-f276d1dd5b1c)
![8](https://github.com/user-attachments/assets/aadeb6ed-c899-4187-8b2a-12baaa0f7b0a)
![10](https://github.com/user-attachments/assets/f78a43f4-fc2d-4186-9d4d-43f775fdb9ca)
![map](https://github.com/user-attachments/assets/475a1899-9306-4c58-9ae7-6f0d952ada51)
![13](https://github.com/user-attachments/assets/7a618402-f95e-45ad-8ba6-fa5f1e714e1e)
![11](https://github.com/user-attachments/assets/7747b510-d582-47bf-bab7-d10f492f421d)
![12](https://github.com/user-attachments/assets/4314a052-eaa3-4bfc-af37-3c7412d5d6a4)

- QR Code Detection and Verification: https://github.com/user-attachments/assets/ac86eaee-c431-4065-b0c3-1c69422930d5

### Identify Testing Factors
Functional testing: We have ensured that the core functions of our application works as planned. Actions were taken and the intended outputs were checked to see if they were correct
Performance testing: Application was put under hefty loads and large data sets to see if the system could handle them. Stress tests were used.
Security testing: E-mail validation to see if a user exists. If an e-mail is already registered before it blocks user from creating another account using the same e-mail
Usability testing: The application was tested to see if it was easy to use by users. Bystanders were used to ensure people from all walks of life could use it
Compatibility testing: Program was testing across multiple platforms
Regression testing: Previously passed test cases were used and were compared with the results
Boundary testing: Edge cases and boundary conditions were checked to ensure the system did not behave unexpectedly

### Test Discussion
- Similarities: Our app and other apps we have searched share some common things such as log in page, offering convenient fuel access or secure payment options.
- Differences: Our app provides larger fuel quantities, and additional features like a wallet widget for payment tracking.

### Test Conclusion
We have tested our functions such as : log in, navigate to, confirm etc. and as a result all of them worked successfully.
