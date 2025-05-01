# CDPC TNP Portal

A Flutter-based Training and Placement Portal for managing student registrations, schedules, and domain-wise student tracking.

## Features

### 1. Student Registration
- Add students with their details (ID, Name, Domain)
- View all registered students in a table format
- Delete student records
- Track total number of registered students

### 2. Domain-wise Student Management
- View students filtered by their selected domain
- Track number of students in each domain
- Manage student records domain-wise
- Delete student records

### 3. Schedule Management
- Upload PDF schedules
- Add notes to schedules
- View all uploaded schedules
- Delete schedules
- Preview uploaded PDFs

### 4. Navigation
- Easy navigation between different sections
- Consistent UI across all pages
- Responsive design for all screen sizes

## Pages

1. **Home Page**
   - Main landing page
   - Quick access to all features

2. **Registration Page**
   - Student registration form
   - Student list table
   - Delete functionality

3. **Domain Page**
   - Domain-wise student filtering
   - Student count per domain
   - Domain-specific student management

4. **Schedule Page**
   - PDF upload functionality
   - Notes addition
   - Schedule list view
   - PDF preview
   - Schedule deletion

5. **Developer Page**
   - Information about developers
   - Contact details

6. **Contact Us Page**
   - Contact information
   - Support details

## Technical Details

### Dependencies
- Flutter SDK
- Firebase Firestore
- Firebase Storage
- File Picker
- Open File
- Intl

### Setup Instructions

1. Clone the repository
```bash
git clone [repository-url]
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure Firebase
   - Add your Firebase configuration files
   - Set up Firestore and Storage

4. Run the application
```bash
flutter run
```

## Usage Guide

### Adding Students
1. Navigate to Registration Page
2. Click "Student" button
3. Fill in student details (ID, Name, Domain)
4. Click "Confirm & Save"

### Managing Domains
1. Navigate to Domain Page
2. Select a domain from dropdown
3. View students in that domain
4. Manage student records as needed

### Managing Schedules
1. Navigate to Schedule Page
2. Write notes (optional)
3. Click "Choose Files" to select PDF
4. Click "Add" to upload
5. View uploaded schedules in the list
6. Preview or delete schedules as needed

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any queries or support, please contact:
- Email: [your-email]
- Website: [your-website]
