# Game Closure Plugin: customURL

## Usage

Include it in the `manifest.json` file under the "addons" section for your game:

~~~
"addons": [
	"customURL"
],
~~~

Also in the `manifest.json` file under the "ios" section, include the URL prefix you want 
your app to respond to:

~~~
"ios": [
	"customURL": "myCustomURL",
],
~~~

At the top of your game's `src/Application.js`:

~~~
import plugins.customURL.customURL;
~~~

This registers your app to respond to a URL request prefixed by the "customURL" declared in your `manifest.json`.

~~~

## Platform-specific notes

iOS support only.