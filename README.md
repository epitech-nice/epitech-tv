# Epitech Tv #
This is a web application build for Epitech Tv.

The application is build whith [gulp](http://gulpjs.com/)

```sh
$>  git clone git@github.com:epitech-nice/epitech-tv.git
$> cd epitech-tv/src/web
$> npm install .
$> ./node_module/gulp/bin/gulp.js
$> ./node_module/gulp/bin/gulp.js dev
```

To access the application you must specify a JSON config file url using the GET parameter (eg: http://epitech-tv.yayo.fr/?config=<CONFIG_URL>)

### Config exemple
```json
{
	"config": {
		"epitech-ws-url": "http://epitech-ws.yayo.fr",
		"djYayo": {
			"ws-url": "http://dj.yayo.fr:4545",
			"room": null
		}
	},
	"blocks": [
		{
			"title": "Infos",
			"playlist": [
				{
					"type": "image",
					"src": "https://dl.dropboxusercontent.com/s/8la9449innnbmvm/we-need-you.png",
					"time": 4000
				}
			]
		},
		{
			"title": "Infos",
			"playlist": [
				{
					"type": "youtube",
					"videoId": "UssE3lIQLr8",
					"volume": 0
				},
				{
					"type": "doodle",
					"title": "Vote Epimovie",
					"doodleId": "zqveyvtvringfmwsdbyfzav9",
					"time": 10000
				}
			]
		},
		{
			"title": "Infos",
			"playlist": [
				{
					"type": "projectsTimelines",
					"city": "FR/NCE",
					"time": 6000000
				}
			]
		},
		{
			"title": "Info Netsoul",
			"playlist": [
				{
					"type": "netsoul",
					"city": "FR/NCE",
					"groups": {
						"ADM": ["anfoss_a", "lallem_a",  "msakni_s"],
						"AER": ["barnea_v", "bertom_j", "cruvei_t", "fourri_l", "heitzl_s"],
						"BDE": ["saadan_f", "garcia_t", "perche_a", "polizz_v", "esclap_e", "guarni_l", "weinha_l"]
					},
					"time": 10000
				},
				{
					"type": "netsoulRank",
					"city": "FR/NCE",
					"time": 5000
				}
			]
		}
	],

	"__exemples": [
		{
			"type": "doodle",
			"title": "Vote Epimovie",
			"doodleId": "zqveyvtvringfmwsdbyfzav9",
			"time": 6000000
		},
		{
			"type": "youtube",
			"videoId": "Rru3J5lErWc",
			"volume": 0
		},
		{
				"type": "iframe",
				"time": 6000000,
				"src": "www.epitech.eu"
		},
		{
			"type": "projectsTimelines",
			"city": "NCE",
			"time": 6000000
		},
		{
			"type": "html",
   			"time": 6000000,
    			"html": "<div style='color: white;text-align:center'> <h1>Lightning talk : créer un bot Minecraft avec LUA</h1><h3>Mercredi 21 mai à 18h30 en salle Tweet</h3><h4>by bichon_b </h4><img height='300px' src='https://dl.dropboxusercontent.com/s/uf2lnn9345ab0kk/bichon_b.png' /></div>"
  		},
		{
			"type": "netsoulRank",
			"city": "FR/NCE",
			"time": 6000000
		},
		{
			"type": "image",
			"src": "http://exemple.com/image.jpg",
			"time": 6000000
		},
		{
			"type": "video",
			"src": "http://yayo.fr/video/tek2_Massacre.ogv",
			"volume": 0
		},
		{
			"type": "doodle",
			"title": "Vote Epimovie",
			"doodleId": "zqveyvtvringfmwsdbyfzav9",
			"time": 6000000
		},
		{
			"type": "countdown",
			"title": "Rendu de de la Bistro:",
			"date": "2014-11-09T21:42:00.000Z",
			"time": 1800000
		}
	]
}
```
