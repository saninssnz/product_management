
#Product Management App
This project is a Flutter-based mobile application designed for efficient product management. It leverages Google Firebase for robust authentication and cloud storage capabilities, ensuring a secure and scalable solution for managing product data. The application is built following the principles of Clean Architecture to promote a maintainable, and scalable codebase. For state management, it employs the BLoC (Business Logic Component) pattern, facilitating reactive and predictable state management throughout the app.

#Features
User Authentication: Securely register and authenticate users using Firebase Authentication. This ensures that only authorized users can access and manage product data.
Product Management: Users can add, view, and manage products. Product data includes essential details such as product name, measurement, and price.
Data Storage: Utilizing Firebase Firestore, the app offers real-time data storage and retrieval, enabling a seamless experience for viewing and updating product information.
Clean Architecture: The app's architecture is designed around clean architecture principles, separating the presentation, business logic, and data layers. This separation enhances the maintainability and scalability of the application.
BLoC for State Management: The BLoC pattern is used for managing the app's state, ensuring a clear separation between the app's user interface and business logic. This approach promotes a more predictable and manageable state management solution.


Dependencies
firebase_auth: For handling user authentication.
cloud_firestore: For storing and retrieving product data in real-time.
flutter_bloc: For implementing the BLoC pattern for state management.
qr_flutter: To generate QR codes for products.
