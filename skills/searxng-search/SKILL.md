# Skill: searxng-search

This skill enables the agent to perform web searches using a local SearXNG instance.

## Trigger
Use this skill when the user explicitly asks to search via SearXNG or when general web search is required and this local instance is preferred.

## Instructions
1.  Construct the search URL: `http://192.168.4.79:8080/search?q={query}&format=json`
2.  Use the `web_fetch` tool to retrieve the JSON response.
3.  Parse the `results` array from the JSON.
4.  Extract the top 5 results.
5.  For each result, return the:
    *   **Title**
    *   **URL**
    *   **Snippet** (found in the `content` field of the JSON)

## Constraints
- If `web_fetch` fails due to internal IP blocking, the gateway configuration must be updated to set `tools.web.fetch.allowInternal: true`.
- Limit output to exactly 5 results to remain lean.

## Example Usage
User: "Search searxng for Bitcoin price"
Agent: (Calls web_fetch with query) -> Returns top 5 results.
