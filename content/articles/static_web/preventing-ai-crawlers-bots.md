+++
title = "Stop AI crawlers and bots from stealing your content"
authors = ["Shane Oatman"]
description = "Discusses how to use robots.txt and features provided by servers and services to prevent AI crawlers and bots from using or stealing your content."
updated = "2025-06-06T22:14:17+00:00"
[extra]
keywords = ["robots.txt", "ai", "bots", "crawler", "web crawler", "hosting", "serverless", "copyright", "html", "content", "pages", "copyright", "artificial intelligence", "content", "work", "web", "world wide web", "intellectual capital", "theft", "misuse", "misappropriation"]
+++


# Introduction

It's a brave new world once again.... and technology, in this case artificial intelligence (AI), promises to do X, Y and Z; however, it's achieving it's awesomeness by standing on the shoulders of thousands of amazing, but limited human beings.  Some may recall the expression.... ["standing on the shoulders of giants"](https://en.wikipedia.org/wiki/Standing_on_the_shoulders_of_giants).  This expression was used to convey the fact that what we have achieved as individual human beings was only possible due to the work of others that came before us.  It's worth noting that "giants" was plural, but with that said, typically folks were relying on the work of a finite number of individual human beings.  In terms of AI, it literally is standing on the shoulders of all the human beings and other AIs that have ever had their work published and made digital.  The written word, images, videos, audio, etc.  It's being trained on all of the digital data that it can get it's hands on.

It gets access to that data by being fed it: manually, via web crawlers, social media, APIs, etc.  Anywhere human beings publish their work in the public domain, AI crawlers and bots are likely to find it.  This is why it's important to protect your content from being illegitimately used by AI web crawlers and bots.  There are several ways to do this, including using robots.txt and features provided by web servers and web site hosting services.

The legal status of AI and it's use of copyrighted content (authorized, unauthorized, licensed, etc...) is still evolving.  As such I've included links to articles on existing lawsuits as well as articles announcing licensing agreements between content providers and AI companies.

## References

- [RobotsNotWanted.txt (history of robots.txt)](https://en.wikipedia.org/wiki/Robots.txt)
- [Robots Exclusion Protocol (robots.txt formalization as a specification)](https://www.rfc-editor.org/rfc/rfc9309.html)
- [mdn web docs - robots.txt](https://developer.mozilla.org/en-US/docs/Glossary/Robots.txt)
- [Google Search Console](https://search.google.com/search-console)
- [Bing Webmaster Tools](https://www.bing.com/webmaster)
- [Voluntary Compliance](https://en.wikipedia.org/wiki/Voluntary_compliance)
- [Copyright.gov (United States Copyright Office)](https://www.copyright.gov/)
- [European Union Intellectual Property Office](https://www.euipo.europa.eu/)
- [Completely Automated Public Turing Test to tell Computers and Humans Apart (CAPTCHAs)](https://en.wikipedia.org/wiki/CAPTCHA)


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

> I'm not a lawyer, i've provided links to both the US and EU copyright offices in the references please refer to those and the legal jurisdiction(s) that apply to you or your organization.  Copyright law varies by jurisdiction.

Copyright is the legal foundation (in applicable jurisdictions) for the protection of your creative work.  It's worthwhile to familiarize your self with how it works.  It's often not required to take an explicit step once your creating work is "fixed" (completed / published).  With that said, there are recommended and optional steps you can take:

- In the United States where I reside, it's often recommended to include a copyright statement or to include the copyright symbol &copy; and the year.
- You can go a step further and explicitly register your work with either the US or the EU copyright offices.

## robots.txt

robots.txt is the de facto standard by which a website can indicate to software agents (web crawlers, search engine bots, AI bots) whether they authorized to consume the content of the site.  robots.txt was created in 1994.  If you were not there to remember the birth of the web This may be helpful context:  [What tech as like in 1994](https://www.businessinsider.com/tech-in-1994-the-year-the-web-was-born-2014-8).  At that time the web was small enough to know the names of all bots in the world.

As you can see in the example below, the default from my static site generator is to allow all software agents (bots, scrapers, crawlers, etc) to access my site:
```
User-agent: *
Disallow:
Allow: /
Sitemap: https://bitweaving.com/sitemap.xml
```

> If **no** robots.txt is available at the root of your domain.  Then all visiting bots understand that they are allowed to crawl, consume, index your site.

Here's an example of a robots.txt file where a list of known bots (sample only) are disallowed (not allowed) to crawl, consume or index my site:

```
User-agent: Amazonbot
User-agent: Andibot
User-agent: anthropic-ai
User-agent: Applebot
User-agent: Applebot-Extended
User-agent: Brightbot 1.0
User-agent: Bytespider
User-agent: CCBot
User-agent: ChatGPT-User
User-agent: Claude-SearchBot
User-agent: Claude-User
User-agent: Claude-Web
User-agent: ClaudeBot
Disallow: /
Sitemap: https://bitweaving.com/sitemap.xml
```

You can customize your robots.txt file to allows or disallow access to specific paths. For example, you can disallow access to a specific directory or file by adding a line like this:

```
Disallow: /path/to/directory/
Disallow: /path/to/file.html
```

There is no actual authorization check or enforcement by a web site.  Those of us publishing on the web are relying on the voluntary compliance of the creators of the software agents that come across websites.  Most of the major search engine bots already do comply... if they didn't there would be potentially be both legal, financial and reputational risk.

With the arrival of AI, it's still true that larger organizations creating and/or using AI bots do voluntarily comply with robots.txt.  With that said there are a number of smaller AI organizations that do not currently comply.  Hence the legal proceeding referenced above.

### Knowing every AI bot in the world

I have no idea how many AI bots are out there potentially reading this website.  Fortunately there are organizations and open source projects that provide a reference list of known AI agents, that's kept current, that do comply with robots.txt.

Here's a github repo with a robots.txt file that is regularly updated with a list of known bots that respect robots.txt:

[https://github.com/ai-robots-txt/ai.robots.txt](https://github.com/ai-robots-txt/ai.robots.txt)

## Relying on hosting provider

### Blocking Bots

Some hosting providers now have support for blocking known AI bots that do not respect robots.txt.  In many cases this is a simple button to enable the behavior for your site.  The hosting provider will be working behind the scenes to keep it's list of misbehaving bots up to date.

- [Cloudflare: Blocking Bots](https://developers.cloudflare.com/bots/get-started/bot-management/#block-ai-bots)

### CAPTCHA & UI Interrupts

Some basic bots, crawlers and scrapers can be blocked using CAPTCHA or other UI interrupts.  Some hosting providers have the ability to detect suspected bot traffic and to challenge them.

- [Cloudflare: Bot Fight Mode](https://developers.cloudflare.com/bots/get-started/bot-fight-mode/)

## Security / Authentication / Authorization

Given the fact that not all crawlers and bots respect your wishes as expressed in robots.txt or in your terms of user/service.  For content that has a particularly high value to your community / customer base, you may want to consider requiring authentication and/or authorization to protect either your entire site or a set of specific content.  If your site does not already provide the option for your customers or community members to authenticate themselves, you may want to consider implementing a login system or integrate with a third-party authentication provider like: Google, Facebook/Instagram, Auth0, Amazon, Akamai, Cloudflare or Microsoft.  Those authentication providers are best positioned to be able to authenticate your users in a secure manner.

You web hosting solution and/or reverse proxy solution, may provide options that you can configure to enable authentication and/or account creation.  This is beyond the scope of this article.

Bots have been known to create accounts pretending to be humans, but the authentication providers mentioned above have systems in place to prevent this.

## Wrap up

Protecting your work from exploitation is a critical step for any creator and any organization.  You'll note this is one of the first articles I wrote for this site.  This makes sense since I don't want to publish more content without have taken all available steps.

Hope you find this helpful~

shane
