# TelegramFeedback
Simple framework for adding Telegram feedback in an iOS App

## Installation
#### CocoaPods
Paste this code to your Podfile:
```
pod 'TelegramFeedback'
```

## Creating Telegram channel
#### Creating bot
* Find the user 'BotFather'
* Send ``` /start ```
* Send ``` /newbot ```
* Follow instructions
#### Creating a channel
* Create 'New Channel'
* Add the created bot to the channel admins

## Usage
First, create an instance of TelegramFeedback:
``` 
let feedback = TelegramFeedback(chatID: "some_channel_id", botName: "some_bot_name")
```
Then call the method 'sendMessage' to send feedback to the channel:
```
feedback.sendMessage("Some message")
```
or:
```
feedback.sendMessage("Some message") { error in
    print(error)
}
```

## Gratz
