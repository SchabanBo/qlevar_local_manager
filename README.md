# qlevar_local_manager [QLM]

This Project will continue as [Localic](https://github.com/SchabanBo/localic)

This app will help you manage you applications locals easily. set you locals in groups, translate them with google translation and then export them to a class that is useable with GetX.

- [qlevar_local_manager [QLM]](#qlevar_local_manager-qlm)
  - [Quick Demo](#quick-demo)
  - [Getting Started](#getting-started)
  - [Data Schema](#data-schema)
  - [Translation](#translation)
  - [Export](#export)
    - [GetX](#getx)
    - [Easy Localization](#easy-localization)

## Features

- Organize your locals in multiple nodes and every node can have multiple nodes and items.
- Export your local to [Getx](#getx) or [Easy-localization](#easy-localization)
- Darg and drop your locals to rearrange them
- Translate them with google Translator to how many language you want

## Quick Demo

[Website](https://local-manager.netlify.app)

https://user-images.githubusercontent.com/49782771/124331112-1095ef80-db8f-11eb-8641-92eb7e58fb29.mp4

## Getting Started

### Windows

- launch the application
- add you first app
  - The name of you app
  - The path where to save the locals in form to reuse them later (this should be in you repo files, so any update on you locals will be saved with the project). This will generate a json file to save your locals, to reopen them in 'QLM' later by you or anyone has the file. so you can share this file with your team.
  - The path where to export the generated files.
- Open you app.
- Go.

### Web

- Navigate to the page.
- Open you app
  - Add new app and the locals data will be save in the local storage so you can return to them again and you can download then at any time.
  - Import an app from the downloaded file you have.
- Go

## Data Schema

The data schema in the application is like json schema. Item and Node.
Every item has key and value. the value here is the translations in all defined languages.
Every Node can have many items and many node.

## Translation

you can translate the local using google translation. you need to set the google apiKey and click translate in the options button.
Only Local items can be translated. and this will translate only the empty locals for the selected item.

## Export

After adding all the data and translate them. you can export it and use it with [GetX](https://pub.dev/packages/get) or [EasyLocalization](https://pub.dev/packages/easy_localization)
In the AppBar click on Export and Export dialog will appear.

### Windows

You can pick the directory where the files should be exported to.
### Web

The exported files will be downloaded.

### GetX

To export the data to file that matches [translations schema](https://github.com/jonataslaw/getx#translations)

- Chose Getx
- Pick the folder to export the class to.
- A file with name `locals.g.dart` will be generated in the folder and ready to use.

### Easy Localization

To export the data to json files with this [structure](https://github.com/aissat/easy_localization#-installation)

- Chose easyLocalization
- Pick the folder to export the files to.
- Json files will be generated every file has the name of language and contains the translations for this language.
