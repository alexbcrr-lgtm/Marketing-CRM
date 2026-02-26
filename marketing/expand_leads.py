from duckduckgo_search import DDGS
import json
import time

queries = [
    'luxury furniture showrooms West Hollywood Design District',
    'high-end furniture stores Costa Mesa SOCO',
    'design district showrooms San Diego La Jolla',
    'luxury furniture showrooms Laguna Niguel',
    'high-end interior design showrooms Los Angeles'
]

new_leads = []

print("🚀 Starting aggressive lead expansion...")

with DDGS() as ddgs:
    for query in queries:
        print(f"Searching: {query}")
        try:
            results = list(ddgs.text(query, region='us-en', max_results=10))
            for r in results:
                new_leads.append({
                    "title": r['title'],
                    "href": r['href'],
                    "body": r['body']
                })
            time.sleep(1) # Be nice
        except Exception as e:
            print(f"Error searching {query}: {e}")

# Save raw results for review
with open('marketing/raw_search_results.json', 'w') as f:
    json.dump(new_leads, f, indent=2)

print(f"✅ Found {len(new_leads)} potential leads. Filtering for high-value targets...")
