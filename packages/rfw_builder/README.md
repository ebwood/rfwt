# rfw_builder contains rfw_builder and rfw_txt tools

## 1. rfw_builder: generate RemoteFlutterWidget tree

## 2. rfw_txt: Converting between .rfw and .rfwtxt formats, including the intermediate class RemoteWidgetLibrary

install rfw2txt and txt2rfw command:

` dart pub global activate rfw_builder `

rfw2txt: convert .rfw to .rfwtxt:

` rfw2txt test1.rfw [-o test.rfwtxt] `

txt2rfw: convert .rfwtxt to .rfw:

` txt2rfw test2.rfwtxt [-o test2.rfw] `
