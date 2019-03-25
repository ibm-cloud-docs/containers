import time
import requests
import json

payload = {"channel":"#doctopus-automation","username":"Jenkins","icon_emoji":":jenkins_ci:","attachments":[{"color":"#00cc00","image_url":"https://previews.123rf.com/images/sarahdesign/sarahdesign1506/sarahdesign150606121/41567086-start-button.jpg","text":"Start nightly build for " + time.strftime("%a %B %d %Y") + "."}]}
requests.post("https://hooks.slack.com/services/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", json.dumps(payload), headers={'content-type': 'application/json'})
