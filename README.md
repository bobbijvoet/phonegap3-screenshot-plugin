# Screenshot plugin for Phonegap 3

Screenshot plugin based on [this plugin](https://github.com/phonegap/phonegap-plugins/tree/master/iOS/Screenshot) for Phonegap 1.6. Currently only for iOs.


## Installation

- Make sure that you have [Node](http://nodejs.org/) and [PhoneGap CLI](https://github.com/mwbrooks/phonegap-cli) installed on your machine.

- Create your PhoneGap example app

```bash
phonegap create my-plugin-example-app && cd $_
```

- Add the plugin to it

```bash
phonegap local plugin add https://github.com/bobbijvoet/phonegap3-screenshot-plugin
```

- Open `index.html and add a button

```html
<button onclick="Screenshot.saveScreenshot();">Take screenshot</button>
```

- Register plugin within `config.xml` of your app

```xml
<feature name="Screenshot">
    <param name="ios-package" value="Screenshot" />
</feature>
```

- Build and run app

```bash
phonegap run ios
```

## Author
Bob Bijvoet