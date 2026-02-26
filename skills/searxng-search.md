# searxng-search Skill

This skill allows you to perform web searches using a local SearXNG instance.

## Usage
When the user asks to "search searxng for {query}" or needs information from the web via the local search engine.

## Implementation Details
It performs a GET request to `http://192.168.4.79:8080/search` with the query and JSON format.

**Note:** `web_fetch` currently blocks internal IP addresses. Use `curl` via `exec` if authorized, or update gateway config to allow internal fetch.

## Top 5 Results Format
1. Title: {title}
2. URL: {url}
3. Snippet: {content}

---
Search query: http://192.168.4.79:8080/search?q={query}&format=json
