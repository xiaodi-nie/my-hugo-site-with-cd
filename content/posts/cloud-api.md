---
title: "Build your own API with Cloud Functions on GCP"
date: 2020-04-03T02:16:03Z
description: "Steps and notes to build an API quickly using Google Cloud Functions"
draft: false
hideToc: false
enableToc: true
enableTocContent: true
author: Xanthia
authorEmoji: 🐹
tags:
- serverless
- google cloud
categories:
- Coding
---

Cloud Functions on GCP allows developers to build lightweight API quickly that scales instantly. The function can be triggered by event or invoked over HTTP/S. In this post we will be building a simple REST API that returns the first sentence of any wikipedia entry in any specified language.

### Steps

**Create a Cloud Function from GCP console**

- Go to the GCP console and find Cloud Functions, click `Create Function`
- Give it a name, here we'll leave the trigger as `HTTP`
- Tick `Allow unauthenticated invocations` for the API to be public. We set this now for simple testing purposes, if you want your API not to be public, you can untick this box and use IAM to set specific permissions after the function has been created.
- Here we'll use the inline editor to put in the source code. Cloud Functions allows you to use `requirements.txt` to install python packages. Just change the `runtime` to `Python 3.7` and put in the function code and package names

![config1](/images/cloud_function1.png)
![config2](/images/cloud_function2.png)

Here we used the wikipedia library to get the info and google translate library to translate that info into any language. Don't forget to put the function name into the `Function to execute` box to make sure the right code is executed when you invoke the API.


```main.py
import wikipedia

from google.cloud import translate

def sample_translate_text(text="YOUR_TEXT_TO_TRANSLATE", 
    project_id="YOUR_PROJECT_ID", language="fr"):
    """Translating Text."""

    client = translate.TranslationServiceClient()

    parent = client.location_path(project_id, "global")

    # Detail on supported types can be found here:
    # https://cloud.google.com/translate/docs/supported-formats
    response = client.translate_text(
        parent=parent,
        contents=[text],
        mime_type="text/plain",  # mime types: text/plain, text/html
        source_language_code="en-US",
        target_language_code=language,
    )
    print(f"You passed in this language {language}")
    # Display the translation for each input text provided
    for translation in response.translations:
        print(u"Translated text: {}".format(translation.translated_text))
    return u"Translated text: {}".format(translation.translated_text)

def translate_test(request):
    """Takes JSON Payload {"entity": "google"}
    """
    request_json = request.get_json()

    if request_json and 'entity' in request_json:
        entity = request_json['entity']
        language = request_json['language']
        print(entity)
        res = wikipedia.summary(entity, sentences=1)
        trans=sample_translate_text(text=res, project_id="cloud-function-demo-272320",
            language=language )
        return trans
    else:
        return f'No Payload'
```

Here the `Function to execute` is `translate_test`


```requirements.txt
# Function dependencies, for example:
# package>=version
wikipedia
google-cloud-translate
```

**Invoke the API**

- After the Cloud Function is created, go to the detail page and find the URL under the `Trigger` tab.

- You can now send an HTTP request to call the API. For example you can use `curl` like this:
```
curl -H "Content-Type: application/json" -X POST -d '{"entity":"facebook","language": "zh"}' <YOUR_URL>
```

The above command would send a JSON payload requesting the first sentence of the wikipedia entry of facebook and translate it into Chinese. It will return something like this:
```
Translated text: Facebook是位于加利福尼亚州门洛帕克的美国在线社交媒体和社交网络服务，也是同名公司Facebook，Inc.的旗舰服务。
```
