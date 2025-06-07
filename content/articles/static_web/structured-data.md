+++
title = "Structured data & enriched results"
authors = ["Shane Oatman"]
description = "Discusses how to include structured data in your site to improve SEO and take advantage enriched search results provided by search engines."
updated = "2025-06-06T22:14:17+00:00"
draft = false
[extra]
keywords = ["structured data", "schema.org", "article", "google search", "bing search", "json-ld", "ld-json", "enriched", "search", "results", "zola", "rust"]
+++

# Introduction

Structured data is data included in an html page that conforms to the W3C schema.org project. Search engines use the structured data to enhance how your page appears in their search results.  For example: a NewsArticle, JobPosting, Organization, Person, etc...

This article will provide information on:

- schema.org
- Google & Bing supported enriched results / schema types
- Examples from this site in JSON-LD


## References

- [Google enriched search results](https://developers.google.com/search/docs/appearance/enriched-search-results)
- [Google enriched result test tool](https://search.google.com/test/rich-results)
- [Bing structured data support](https://www.bing.com/webmasters/help/marking-up-your-site-with-structured-data-3a93e731)
- [schema.org](https://schema.org)
- [JSON-LD Specification](https://www.w3.org/TR/json-ld11/)

## Schema of structured data

Structured data relies on the field and objects types defined by schema.org.  Navigating to schema.org you can search for any thing that you are publishing in your page.  What type of information is presented on a particular web page usually maps to a schema.org type.  A few examples for illustration purposes:

- CreativeWork, Article, TechArticle
- JobPosting
- Person
- Organization
- Product
- Event

> If the content of your page is novel and does not map to an existing schema.org type definition, there is a process by which to submit a proposal for a new type to the schema.org W3C community.

Schema.org uses polymorphism / inheritance with all types ultimately being derived from a thing.  If in your structured data you do not specify a specific type, search engines and other tools consuming your page will assume that a "thing" is being described.
In the first example above [CreativeWork](https://schema.org/CreativeWork) is derived from Thing, [Article](https://schema.org/Article) is derived from CreativeWork, [TechArticle](https://schema.org/TechArticle) derives from Article.  Schema.org provides examples for each type in a variety of different encoding (ways of including the structured data in the page) at the bottom of the type description page.

Here's an example of the JSON-LD encoding of an Article from schema.org:
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "author": "John Doe",
  "name": "How to Tie a Reef Knot"
}
</script>
```
