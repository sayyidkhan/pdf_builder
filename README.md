<img src="https://user-images.githubusercontent.com/22993048/94937048-a5d15e00-0501-11eb-890e-df3a4561d5e6.jpg" width="6%" height="6%">

# PDF Builder (Flutter Mobile Application)
### Built in Flutter & SQL
A Mobile App which you will use a form to fill up your contract details and generate a pdf from the form which u have filled up.

### How i built it
1. i used Flutter & dart to construct the UI of the application
2. data of the filename and filepath is stored in a sql database on the mobilephone locally using sql
3. i used a pdf engine(backend framework) to be able to generating and reading of the the pdf file
4. i used dart IO Operations to manage the renaming and the deleting of the unwanted files

### How to run the application
1. git clone the respository
2. ensure u have flutter sdk installed on your computer
3. navigate to folder directory of pdf_builder
4. open terminal on the current folder directory
5. type "flutter run" on the terminal and hit enter to run the emulator

** ensure to build the pubspec.yaml file dependencies first prior to running on the mobile app emulator **

## App Logo on IOS Homepage
<img width="300" src="https://user-images.githubusercontent.com/22993048/94937364-11b3c680-0502-11eb-802c-905d034e674d.png">

## Mobile App Use
### Homepage
<img src="https://user-images.githubusercontent.com/22993048/94992874-8862c980-05bf-11eb-86d7-5e66e20c9369.PNG" width="30%" height="30%">

User creates a new PDF file by clicking on the plus button

### Create PDF By Filling Up a Form
<img src="https://user-images.githubusercontent.com/22993048/94993083-05427300-05c1-11eb-8097-1e39d1670410.jpg" width="120%" height="120%">

1. Invoice Details
2. Contractor Details
3. Client Details
4. Service Details
user fills up the document via the four step process

### Confirmation Screens while creating the PDF
<img src="https://user-images.githubusercontent.com/22993048/94993252-3a02fa00-05c2-11eb-8bae-69a6242510d8.jpg" width="120%" height="120%">

User can go back to the main or view the PDF screen.

### Updated UI Homepage (with the new PDF added)
<img src="https://user-images.githubusercontent.com/22993048/94993323-b39ae800-05c2-11eb-80d6-7c02730fe210.PNG" width="30%" height="30%">

### PDF Preview & Download Screen
<img src="https://user-images.githubusercontent.com/22993048/94993357-05437280-05c3-11eb-85b2-77667c945505.jpg" width="100%" height="100%">
User is able to view PDF and download / Send PDF to client
