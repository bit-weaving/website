+++
title = "Stop AI crawlers and bots from using/stealing your content"
authors = ["Shane Oatman"]
description = "Discusses how to use robots.txt and features provided by servers and services to prevent AI crawlers and bots from using or stealing your content."
keywords = ["robots.txt", "ai", "bots", "crawler", "web crawler", "hosting", "serverless", "copyright", "html", "content", "pages"]
updated = "2025-05-09"
[meta]
    title = "Stop AI crawlers and bots from using/stealing your content"
    description = "Discusses how to use robots.txt and features provided by servers and services to prevent AI crawlers and bots from using or stealing your content."
    author = "Shane Oatman"
+++


# Introduction

It's a brave new world once again.... and technology, in this case artificial intelligence (AI), promises to do X, Y and Z; however, it's achieving it's awesomeness by standing on the shoulders of thousands of amazing, but limited human beings.  Some may recall the expression.... ["standing on the shoulders of giants"](https://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants).  This expression was used to convey the fact that what we as individuals have achieved was only possible due to the work of others that came before us.  It's worth noting that "giants" was plural, but with that said, typically folks were relying on the work of a finite number of individual human beings.  In terms of AI, it literally is standing on the shoulders of all the human beings and other AIs that have ever had their work published and made digital.  The written word, images, videos, audio, etc.  It's being trained on all of the digital data that it can get it's hands on.

It gets access to that data by being fed it: manually, via web crawlers, social media, APIs, etc.  Anywhere human beings publish their work in the public domain, AI crawlers and bots are likely to find it.  This is why it's important to protect your content from being illegimately used by AI web crawlers and bots.  There are several ways to do this, including using robots.txt and features provided by servers and services.  You can also implement your own.

The legal status of AI and it's use of copyrighted content (authorized, unauthorized, licensed, etc...) is still evolving.  As such I've included links to articles on existing lawsuits as well as articles announcing licening agreements between content providers and AI companies.

## References

- [RobotsNotWanted.txt (history of robots.txt)](https://en.wikipedia.org/wiki/Robots.txt)
- [Robots Exclusion Protocol (robots.txt formalization as a specification)](https://www.rfc-editor.org/rfc/rfc9309.html)
- [mdn web docs - robots.txt](https://developer.mozilla.org/en-US/docs/Glossary/Robots.txt)
- [Google Search Console](https://search.google.com/search-console)
- [Bing Webmaster Tools](https://www.bing.com/webmaster)
- [Voluntary Compliance](https://en.wikipedia.org/wiki/Voluntary_compliance)
- [Copyright.gov (United States Copyright Office)](https://www.copyright.gov/)

## Lawsuits against AI organizations

This is a non-exhaustive list of lawsuits against AI organizations.

- [New York Times vs Microsoft and OpenAI](https://www.npr.org/2025/03/26/nx-s1-5288157/new-york-times-openai-copyright-case-goes-forward)
- [Reddit sues Anthropic](https://www.nytimes.com/2025/06/04/technology/reddit-anthropic-lawsuit-data.html)
- [Wired AI Case Tracker](https://www.wired.com/story/ai-copyright-case-tracker/)

## Legal use of content

This is a non exhaustive list of legal uses of content.

>Note that while AI is making licensing deals with media companies and social media platforms, they in turn are in some cases dealing with lawsuits from individual human being content creators or social media platform users.

- [New York Times and Amazon sign licensing agreement](https://www.nytimes.com/2025/05/29/business/media/new-york-times-amazon-ai-licensing.html)
- [AI Content Licensing lessons from Time and Factiva](https://digitalcontentnext.org/blog/2025/03/06/ai-content-licensing-lessons-from-factiva-and-time/)
- [Media industry's race to license content for AI](https://www.forbes.com/sites/billrosenblatt/2024/07/18/the-media-industrys-race-to-license-content-for-ai/)

## Copyright

## robots.txt

robots.txt was created in 1994 and became a defacto standard for the early web in that same year.  If you were not there to remember the birth of the web This may be helpful context:  [What tech as like in 1994](https://www.businessinsider.com/tech-in-1994-the-year-the-web-was-born-2014-8).  At that time the web was small enough to known the names of all bots in the world.  As such you could create a file for bots to read that would tell them what they were allowed to do in terms of crawling and indexing your website.
