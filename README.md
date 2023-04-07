# WhatsUpGenius?

WhatsUpGenius? is a WhatsApp bot that allows you to add music to a spotify playlist. The application, developed with Ruby on Rails, consists of a web interface to connect to Spotify and enter the phone number with which you want to communicate with the bot. Then, you just have to send a message to the bot to start using it.

The application uses :
- Twilio (WhatsApp)
- Spotify (you know why, right?)
- OpenAI (to communicate with the bot in a natural way)

Thus, thanks to OpenAI, each bot response (track found or not, music added, etc.) is unique. Also, when the bot asks you if you want to add the music to your playlist, no keyword is required. The bot is able to determine whether your answer is positive or negative and act accordingly.

![demo](https://media.cleanshot.cloud/media/44712/CcunEmeWwLNMc552DuPLTCa2kmDOYspEnAxEAnaL.jpeg?Expires=1680904722&Signature=WMQpIg4arTbPXp8FH4nHmr8OCxq6SC0v7Gf-80f7v7OLst62DavZnGhVeJDpGGnGTO-e3ZQSCKzYDsLnGlMpSyzKSz58b66VAkkUiIIBgx-cJcLGVuw3-3khZaRFgGjPp7jEpxYBG2cz1PA7aKkgzVLuWtUVPnWeo9-uLLe1piD32G1uxpw7iuy96ORXptQ~HsiDZx~c-SfG0WDDKZuiDdVH2VVV0pKUzkirFskqY55XgpsTWJ2H0jEoNwTe-6ZA10XX1NX2ICprWhB4l21sLkmjVCr4EG8WRsxZQnFCryAEijxHVE2aCHFFJBGxomzzu~YCo8j2BdG7YgcQc4yT2A__&Key-Pair-Id=K269JMAT9ZF4GZ)

## How to install it

### Spotify

On your [Spotify developer dashboard](https://developer.spotify.com/dashboard), create an application. In the settings, enter the following redirect URI: `http://localhost:3000/auth/spotify/callback`. Copy your `client ID` and `client secret` then add it to the credentials:

`EDITOR=nano bin/rails credentials:edit`

```
spotify:
  client_id: your_client_id
  client_secret: your_client_secret
```

### Twilio

Now, go to Twilio and create a WhatsApp sandbox (you can try through [this link](https://console.twilio.com/us1/develop/sms/try-it-out/whatsapp-learn), it's a pain to find your way in their dashboard ngl). Once you have created your sandbox, copy the phone number and code to join the sandbox. In your sandbox settings, we need to add a URL so that Twilio can send us webhooks. To do so, create an ngrok tunnel:

```
ngrok http 3000
```

Copy the generated URL and add the following path: `/webhooks/twilio/messages`. For example, mine looks like this: `https://e80f-2a01-e0a-9a9-120-5c92-a021-b398-5c3d.eu.ngrok.io/webhooks/twilio/messages`

![Twilio sandbox](https://media.cleanshot.cloud/media/44712/mCTUmtf2uUssOqomPkFJUG02txXfkCQnU7xzv7M4.jpeg?Expires=1680902153&Signature=iU~EFZVjZ9~FK9YE5yJDWW-gMPaqPMbXOWv1ICosvDOpU87SAhsOM1i0F7NLb2F8o03~UwibsURmRggVII-QaHAIgOkbf1C7OkxR3MhDKSnGF~s0I8ggMk6g09C~xiwCuyeAGoXqP9hpJIMbES-xdTYr3NH2tL11HkDvEk3xTOJA5vGaRU2ZDrbTwzrEs2-xikNPTvh5moYcLHuhd~874CnbACBcFKoNRv4qtu84kE7AqvhJD9Lesc2nDC6ykv3bbOrJp~qMVPFgbF0mvmowp4t5EpRwmUM-h2eZZJN4EaB9V4nhkYbEMx6m6Rj3LYz9Q0pgZWOlk6-~hwRIiVbDdA__&Key-Pair-Id=K269JMAT9ZF4GZ)

Then, go to your account and copy your API token. Again, add these informations to the credentials:

```
twilio:
  auth_token: your_auth_token
  whatsapp_number: your_whatsapp_phone_number
  join_code: your_sandbox_join_code

```

Great! Now, we just need to get our API token for OpenAI.

### OpenAI

Go to your [OpenAI account](https://platform.openai.com/account/api-keys), API Keys, and create a secret key. Copy it and add it to the credentials:

```
openai:
  access_token: your_secret_key
```

Prefect!

### Start the application

Make sure your ngrok tunnel is open. If not, restart it and update the URL in the settings for the WhatsApp sandbox on Twilio.

```
cd whatsupgenius
bundle
rails db:setup
bin/dev
```

Visit `http://localhost:3000/` and let's go!
