# Helpful Asesprite Scripts

## Expand Selection to Grid
![](https://github.com/ZachIsAGardner/ZacharyAsepriteScripts/blob/main/docs/ase_expand_to_grid.gif)

## Resize Sprite Sheet
![](https://github.com/ZachIsAGardner/ZacharyAsepriteScripts/blob/main/docs/ase_resize_tiles.gif)

## Aseprite Opener
![](https://github.com/ZachIsAGardner/ZacharyAsepriteScripts/blob/main/docs/ase_open_existing.gif)
On Windows Aseprite will not open .ase and .png files in the existing Aseprite instance. This is a workaround for that. Combined with VsCode and this [extension](https://github.com/tjx666/open-in-external-app) you can open files from VsCode and straight into Aseprite.

In settings.json:
```
"openInExternalApp.openMapper": [
        {
            "extensionName": "png",
            "apps": [
                {
                    "title": "Open in Aseprite (.png)",
                    "shellCommand": "path to file/aseprite_opener.ahk ${file}"
                }
            ]
        },
        {
            "extensionName": "ase",
            "apps": [
                {
                    "title": "Open in Aseprite (.ase)",
                    "shellCommand": "path to file/aseprite_opener.ahk ${file}"
                }
            ]
        }
    ],
```
