# moviesapp

A flutter project interacting with the Movies Database API.

## Getting Started

You first need flutter to be installed on your machine.

To install the packages needed, run:
```bash
flutter packages get
```

then, generate the web pages with:
```bash
flutter build web
```

Firebase will be used here for the webpage, run:
```bash
npm install
# and then
npm run init
```
then configure your firebase initialization to **Hosting: Configure files for Firebase Hosting**.

the public directory of the firebase configuration is on `build/web`.

next, run:
```bash
npm start
```
you should get then your **Hosting URL** shown as result of your deployment with firebase